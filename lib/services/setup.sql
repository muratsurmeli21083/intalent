-- SQL Script for Multi-Tenant InTalent SaaS

-- 0. Tenants Table
CREATE TABLE IF NOT EXISTS public.tenants (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  company_name TEXT NOT NULL,
  domain TEXT UNIQUE,
  logo_url TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 1. Users Table
CREATE TABLE IF NOT EXISTS public.profiles (
  id UUID REFERENCES auth.users ON DELETE CASCADE PRIMARY KEY,
  tenant_id UUID REFERENCES public.tenants(id),
  first_name TEXT,
  last_name TEXT,
  email TEXT UNIQUE,
  role TEXT DEFAULT 'candidate' CHECK (role IN ('admin', 'candidate')),
  current_progress_task_id UUID,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Tasks Table
CREATE TABLE IF NOT EXISTS public.tasks (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  tenant_id UUID REFERENCES public.tenants(id),
  name TEXT NOT NULL,
  description TEXT,
  type TEXT, -- 'personality', 'motivation', 'skill_test'
  total_questions INTEGER,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. Jobs Table
CREATE TABLE IF NOT EXISTS public.jobs (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  tenant_id UUID REFERENCES public.tenants(id),
  title TEXT NOT NULL,
  position TEXT,
  city TEXT,
  definition TEXT,
  logo_url TEXT,
  required_tests JSONB, -- Array of test IDs
  required_competencies JSONB, -- Map of {competency: min_score}
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 4. Questions Table (Updated for Dynamic Bank)
CREATE TABLE IF NOT EXISTS public.questions (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  tenant_id UUID REFERENCES public.tenants(id),
  task_id UUID REFERENCES public.tasks(id) ON DELETE CASCADE,
  type TEXT, -- Kişilik, Yetenek, Bilgi
  category TEXT NOT NULL, -- Sayısal, Sözel, Mantıksal, İngilizce, Kişilik
  content TEXT NOT NULL, -- Soru metni. (HTML/Markdown destekli)
  image_url TEXT, -- Resimli sorular için Supabase Storage linki
  options JSONB NOT NULL, -- {"A": "Metin", "B": "Metin"} formatında şıklar
  correct_answer TEXT, -- Doğru şık (A, B, C, D). Kişilik envanterinde null.
  dimension_id TEXT, -- Kişilik envanteri için: Dominance, Influence vb.
  points INTEGER DEFAULT 1, -- Bilgi sınavları için ağırlık puanı
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 5. Responses Table (14-point/forced choice distribution)
CREATE TABLE IF NOT EXISTS public.responses (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  tenant_id UUID REFERENCES public.tenants(id),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  task_id UUID REFERENCES public.tasks(id) ON DELETE CASCADE,
  question_id UUID REFERENCES public.questions(id) ON DELETE CASCADE,
  allocated_points INTEGER NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 6. Scores Table
CREATE TABLE IF NOT EXISTS public.scores (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  tenant_id UUID REFERENCES public.tenants(id),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  task_id UUID REFERENCES public.tasks(id) ON DELETE CASCADE,
  competency_name TEXT NOT NULL,
  total_score DECIMAL,
  consistency_index DECIMAL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- RLS (Row Level Security) - Basic Isolation
-- Note: You should enable RLS on each table and create policies 
-- like: CREATE POLICY tenant_isolation ON public.jobs USING (tenant_id = (SELECT tenant_id FROM profiles WHERE id = auth.uid()));

-- Set up Row Level Security (RLS)
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.responses ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.scores ENABLE ROW LEVEL SECURITY;

-- Allow users to read/write their own data
CREATE POLICY "Users can view their own profile" ON public.profiles FOR SELECT USING (auth.uid() = id);
CREATE POLICY "Users can update their own profile" ON public.profiles FOR UPDATE USING (auth.uid() = id);
CREATE POLICY "Users can insert their own responses" ON public.responses FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can view their own scores" ON public.scores FOR SELECT USING (auth.uid() = user_id);
