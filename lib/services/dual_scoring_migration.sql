-- ============================================================
-- InTalent Dual Scoring System Migration
-- Çalıştırma: Supabase Dashboard → SQL Editor → New Query
-- ============================================================

-- ADIM 1: jobs tablosuna weight_coefficients sütunu ekle
ALTER TABLE public.jobs 
  ADD COLUMN IF NOT EXISTS weight_coefficients JSONB DEFAULT '{}';

-- Örnek katsayı formatı:
-- {
--   "sayisal": 3,
--   "sozel": 2,
--   "liderlik": 5,
--   "kisilik": 4,
--   "ingilizce": 2,
--   "motivasyon": 3
-- }

-- ADIM 2: profiles tablosuna journey_score sütunu ekle
ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS journey_score DECIMAL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS onboarding_completed BOOLEAN DEFAULT FALSE;

-- ADIM 3: scores tablosuna competency_type sütunu ekle (kategori bazlı skor)
ALTER TABLE public.scores
  ADD COLUMN IF NOT EXISTS competency_type TEXT; 
  -- Değerler: 'sayisal', 'sozel', 'liderlik', 'kisilik', 'ingilizce', 'motivasyon'

-- ADIM 4: Journey Skoru hesaplama fonksiyonu
-- Journey Skoru = Adayın sisteme güvenilirliği (profil doluluk oranı)
-- %70 altı → ilanlar kilitli, %70+ → ilanlar görünür
CREATE OR REPLACE FUNCTION public.calculate_journey_score(p_user_id UUID)
RETURNS DECIMAL AS $$
DECLARE
  v_score DECIMAL := 0;
  v_profile RECORD;
  v_test_count INTEGER;
BEGIN
  SELECT * INTO v_profile FROM public.profiles WHERE id = p_user_id;
  
  -- Profil temel bilgileri: 20 puan
  IF v_profile.first_name IS NOT NULL AND v_profile.last_name IS NOT NULL THEN
    v_score := v_score + 20;
  END IF;
  
  -- E-posta doğrulandı: 10 puan (Supabase auth'dan)
  IF v_profile.email IS NOT NULL THEN
    v_score := v_score + 10;
  END IF;
  
  -- Tamamlanan test sayısına göre: her test 10 puan (max 70)
  SELECT COUNT(DISTINCT competency_type) INTO v_test_count
  FROM public.scores WHERE user_id = p_user_id;
  
  v_score := v_score + LEAST(v_test_count * 10, 70);
  
  RETURN LEAST(v_score, 100); -- Maksimum 100
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ADIM 5: Match Skoru hesaplama fonksiyonu
-- Match Skoru = Adayın bir ilana özel uygunluğu
-- İK'nın belirlediği katsayılarla adayın test skorları çarpılır
CREATE OR REPLACE FUNCTION public.calculate_match_score(p_user_id UUID, p_job_id UUID)
RETURNS DECIMAL AS $$
DECLARE
  v_weights JSONB;
  v_total_weight DECIMAL := 0;
  v_weighted_sum DECIMAL := 0;
  v_competency TEXT;
  v_weight DECIMAL;
  v_score DECIMAL;
  v_match DECIMAL := 0;
BEGIN
  -- İlandaki katsayıları al
  SELECT weight_coefficients INTO v_weights
  FROM public.jobs WHERE id = p_job_id;
  
  IF v_weights IS NULL OR v_weights = '{}'::JSONB THEN
    RETURN 0;
  END IF;

  -- Her yetkinlik için ağırlıklı skor hesapla
  FOR v_competency, v_weight IN
    SELECT key, value::DECIMAL FROM jsonb_each_text(v_weights)
  LOOP
    SELECT COALESCE(MAX(total_score), 0) INTO v_score
    FROM public.scores
    WHERE user_id = p_user_id AND competency_type = v_competency;
    
    v_weighted_sum := v_weighted_sum + (v_score * v_weight);
    v_total_weight := v_total_weight + v_weight;
  END LOOP;

  IF v_total_weight > 0 THEN
    v_match := (v_weighted_sum / v_total_weight);
  END IF;

  RETURN LEAST(ROUND(v_match, 1), 100);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ADIM 6: Bir ilan için tüm adayları Match Skoru ile listeleyen VIEW
CREATE OR REPLACE VIEW public.candidate_job_matches AS
SELECT
  p.id AS candidate_id,
  p.first_name,
  p.last_name,
  p.email,
  p.journey_score,
  j.id AS job_id,
  j.title AS job_title,
  public.calculate_match_score(p.id, j.id) AS match_score
FROM public.profiles p
CROSS JOIN public.jobs j
WHERE p.role = 'candidate';

-- ADIM 7: Match Skoru'na göre sıralayan yardımcı fonksiyon (İK Dashboard için)
CREATE OR REPLACE FUNCTION public.get_ranked_candidates_for_job(p_job_id UUID)
RETURNS TABLE (
  candidate_id UUID,
  first_name TEXT,
  last_name TEXT,
  email TEXT,
  journey_score DECIMAL,
  match_score DECIMAL
) AS $$
BEGIN
  RETURN QUERY
  SELECT
    p.id,
    p.first_name,
    p.last_name,
    p.email,
    public.calculate_journey_score(p.id) AS journey_score,
    public.calculate_match_score(p.id, p_job_id) AS match_score
  FROM public.profiles p
  WHERE p.role = 'candidate'
  ORDER BY public.calculate_match_score(p.id, p_job_id) DESC;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ADIM 8: RLS - fonksiyonlar herkese açık (sadece SECURITY DEFINER ile çalışır)
GRANT EXECUTE ON FUNCTION public.calculate_journey_score TO authenticated;
GRANT EXECUTE ON FUNCTION public.calculate_match_score TO authenticated;
GRANT EXECUTE ON FUNCTION public.get_ranked_candidates_for_job TO authenticated;
