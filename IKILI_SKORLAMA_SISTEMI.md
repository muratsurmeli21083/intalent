# İKİLİ SKORLAMA VE DİNAMİK SIRALAMA SİSTEMİ

## 📌 Genel Mimari

Sistem iki bağımsız motora dayalı olarak çalışır:

### Motor 1: **Journey Skoru** (Adayın Şeffaflığı - 0-100)
- **Amaç**: Adayın sistemdeki güvenilirlik / veri tamlığı seviyesi
- **Hesaplama**: Adayın profili dolum oranı + tamamlanan testler
- **Kullanım**: İK panelinde "Güvenilirlik Rozeti" olarak gösterim
- **Sıramada Etkisi**: YOK - sadece bilgilendirme

### Motor 2: **Match Skoru** (İşe Uygunluk - 0-100)
- **Amaç**: Adayın belirli bir pozisyon için ne kadar uyumlu olduğu
- **Hesaplama**: Adayın test sonuçları × İK'cı tarafından tanımlanan katsayılar
- **Kullanım**: **ASıL Sıralama Kriteri**
- **Dinamik**: Her ilan için farklı

---

## 🗂️ DATABASE SCHEMA DEĞIŞIKLIKLERI

### 1. Jobs Tablosu - `weight_coefficients` Sütunu Ekle

```sql
-- Migration: Add weight_coefficients to jobs table
ALTER TABLE jobs
ADD COLUMN weight_coefficients JSONB DEFAULT '{}'::jsonb;

-- Örnek veri yapısı:
{
  "numerical_score": 3,      -- Sayısal Yetenek puanı (ağırlık)
  "personality_leadership": 5, -- Kişilik: Liderlik boyutu
  "personality_influence": 2,  -- Kişilik: Etki boyutu
  "english_score": 2,         -- İngilizce puanı
  "logical_reasoning": 3,     -- Mantıksal Akıl Yürütme
  "verbal_score": 2           -- Sözel Yetenek
}
```

---

## 📊 HESAPLAMA YAZILIMI

### A. Journey Skoru Hesaplaması

```dart
// lib/services/scoring_service.dart

class ScoringService {
  static const _supabase = Supabase.instance.client;

  /// Journey Skoru hesapla (Adayın Şeffaflığı)
  static Future<double> calculateJourneyScore(String userId) async {
    try {
      final profile = await _supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();

      // Profil dolum oranı (%)
      double profileCompleteness = _calculateProfileCompleteness(profile);

      // Tamamlanan testler
      final testResults = await _supabase
          .from('test_results')
          .select()
          .eq('user_id', userId);

      int completedTests = testResults.length;
      double testBonus = (completedTests / 4) * 30; // Max 30 puan

      // Toplam Journey Skoru
      double journeyScore = (profileCompleteness * 0.7) + testBonus;
      return journeyScore.clamp(0, 100);
    } catch (e) {
      print('Journey Score Hesaplama Hatası: $e');
      return 0;
    }
  }

  static double _calculateProfileCompleteness(Map profile) {
    List<String> requiredFields = [
      'first_name', 'last_name', 'email', 'phone',
      'city', 'experience_level', 'bio'
    ];
    
    int filledFields = requiredFields
        .where((field) => profile[field] != null && profile[field].toString().isNotEmpty)
        .length;
    
    return (filledFields / requiredFields.length) * 100;
  }
}
```

### B. Match Skoru Hesaplaması (İlan Özel)

```dart
/// Match Skoru hesapla (İşe Uygunluk)
/// Parameterler:
/// - userId: Aday ID
/// - jobId: İlan ID
/// - weights: jobs.weight_coefficients
static Future<double> calculateMatchScore({
  required String userId,
  required String jobId,
  required Map<String, dynamic> weights,
}) async {
  try {
    // Adayın test sonuçlarını al
    final scores = await _supabase
        .from('scores')
        .select()
        .eq('user_id', userId)
        .single();

    double matchScore = 0;
    int totalWeight = 0;

    // Her kriter için ağırlıklı puanlama
    final criteriaMap = {
      'numerical_score': scores['numerical_score'] ?? 0,
      'personality_leadership': scores['personality_leadership'] ?? 0,
      'personality_influence': scores['personality_influence'] ?? 0,
      'english_score': scores['english_score'] ?? 0,
      'logical_reasoning': scores['logical_reasoning'] ?? 0,
      'verbal_score': scores['verbal_score'] ?? 0,
    };

    criteriaMap.forEach((criteria, score) {
      int weight = weights[criteria] ?? 1;
      matchScore += (score * weight);
      totalWeight += weight;
    });

    // Normalize et (0-100)
    double normalizedScore = totalWeight > 0
        ? (matchScore / totalWeight)
        : 0;

    return normalizedScore.clamp(0, 100);
  } catch (e) {
    print('Match Score Hesaplama Hatası: $e');
    return 0;
  }
}

/// Bir ilanın tüm adayları Match Skoru ile sırala
static Future<List<Map>> getRankedCandidates(String jobId) async {
  try {
    // 1. İlan bilgilerini al (weight_coefficients dahil)
    final job = await _supabase
        .from('jobs')
        .select()
        .eq('id', jobId)
        .single();

    Map<String, dynamic> weights = job['weight_coefficients'] ?? {};

    // 2. Tüm adayları al
    final candidates = await _supabase
        .from('job_applications')
        .select('user_id')
        .eq('job_id', jobId)
        .neq('status', 'rejected');

    // 3. Her aday için Match Skoru hesapla
    List<Map> rankedList = [];
    for (var app in candidates) {
      String userId = app['user_id'];
      
      // Match Skoru
      double matchScore = await calculateMatchScore(
        userId: userId,
        jobId: jobId,
        weights: weights,
      );

      // Journey Skoru
      double journeyScore = await calculateJourneyScore(userId);

      rankedList.add({
        'user_id': userId,
        'match_score': matchScore,
        'journey_score': journeyScore,
      });
    }

    // 4. Match Skoru'na göre (azalan sırada) sırala
    rankedList.sort((a, b) => (b['match_score'] as double)
        .compareTo(a['match_score'] as double));

    return rankedList;
  } catch (e) {
    print('Aday Sıralama Hatası: $e');
    return [];
  }
}
```

---

## 🎨 İK DASHBOARD GÖSTERIMI

### Aday Listesi Görünümü

```dart
// lib/screens/recruiter/candidate_list_screen.dart

class CandidateCard extends StatelessWidget {
  final Map candidate;
  final double matchScore;
  final double journeyScore;

  const CandidateCard({
    required this.candidate,
    required this.matchScore,
    required this.journeyScore,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Aday Bilgisi
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(candidate['avatar_url'] ?? ''),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${candidate['first_name']} ${candidate['last_name']}',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(candidate['job_title'] ?? 'Pozisyon Belirtilmemiş'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // MATCH SKORU (Ana Sıralama Kriteri)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('İşe Uygunluk Skoru',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Text('${matchScore.toStringAsFixed(1)}/100',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF003EC7),
                      ),
                    ),
                  ],
                ),
                
                // Match Score Progress Bar
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: matchScore / 100,
                      minHeight: 8,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        matchScore >= 70 ? Colors.green :
                        matchScore >= 50 ? Colors.orange :
                        Colors.red
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 12),
          
          // JOURNEY SKORU (Güvenilirlik Rozeti)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(0xFFF0F4FF),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0xFFD2E0FE), width: 1),
              ),
              child: Row(
                children: [
                  Icon(Icons.verified, color: Colors.amber, size: 16),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Güvenilirlik Rozeti',
                        style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                      ),
                      Text('Journey Skoru: ${journeyScore.toStringAsFixed(1)}/100',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Spacer(),
                  Text(
                    journeyScore >= 70 ? '✓ Yüksek Veri' :
                    journeyScore >= 50 ? '~ Orta Veri' :
                    '! Eksik Veri',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
```

---

## 🔧 SUPABASE SQL FUNCTION (İsteğe Bağlı)

İlan başı Match Skoru hesaplayan SQL Function:

```sql
CREATE OR REPLACE FUNCTION calculate_match_score(
  p_user_id UUID,
  p_job_id UUID
) RETURNS TABLE(match_score NUMERIC) AS $$
BEGIN
  RETURN QUERY
  SELECT
    CASE
      WHEN SUM(weight) = 0 THEN 0
      ELSE ROUND((SUM(score * weight)::NUMERIC / SUM(weight)), 2)
    END AS match_score
  FROM (
    SELECT
      COALESCE(s.numerical_score, 0) AS score,
      COALESCE((j.weight_coefficients->>'numerical_score')::INT, 1) AS weight
    FROM scores s
    CROSS JOIN jobs j
    WHERE s.user_id = p_user_id AND j.id = p_job_id
    
    UNION ALL
    
    SELECT
      COALESCE(s.personality_leadership, 0),
      COALESCE((j.weight_coefficients->>'personality_leadership')::INT, 1)
    FROM scores s
    CROSS JOIN jobs j
    WHERE s.user_id = p_user_id AND j.id = p_job_id
    -- ... diğer kriteriler
  ) score_weights;
END;
$$ LANGUAGE plpgsql;

-- Kullanım:
SELECT * FROM calculate_match_score(
  'user-uuid-here',
  'job-id-here'
);
```

---

## 📝 IMPLEMENTASYON KONTROL LİSTESİ

- [ ] Jobs tablosuna `weight_coefficients` sütunu ekle
- [ ] `ScoringService` sınıfını oluştur
- [ ] `calculateJourneyScore()` metodu test et
- [ ] `calculateMatchScore()` metodu test et
- [ ] `getRankedCandidates()` metodu test et
- [ ] İK Dashboard aday listesi UI güncelle
- [ ] Match Skoru gösterimini Supabase Realtime ile bağla
- [ ] İlan oluştururken katsayılar GI'sini ekle

---

## 💡 ÖRNEK SENARYO

**İlan**: Senior Flutter Developer
**Katsayılar**:
- Sayısal Yetenek: **3x**
- Mantıksal Akıl Yürütme: **3x**
- Kişilik (Liderlik): **2x**
- İngilizce: **2x**

**Aday A**:
- Sayısal: 80, Mantık: 85, Liderlik: 60, İngilizce: 75
- Match Skoru = ((80×3) + (85×3) + (60×2) + (75×2)) / (3+3+2+2) = **77.5/100** ✅

**Aday B**:
- Sayısal: 50, Mantık: 90, Liderlik: 95, İngilizce: 70
- Match Skoru = ((50×3) + (90×3) + (95×2) + (70×2)) / 10 = **76.0/100** ⚠️

**Sıralama**: Aday A > Aday B (ilk sırada Aday A gösterilir)
