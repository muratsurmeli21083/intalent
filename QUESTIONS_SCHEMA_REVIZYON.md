# QUESTIONS TABLO SCHEMA REVİZYONU

## 📋 YENİ SCHEMA YAPISI

| Sütun Adı | Veri Tipi | Null? | Açıklama |
|-----------|-----------|-------|----------|
| `id` | UUID | NO | Sorunun benzersiz kimliği (Primary Key) |
| `type` | TEXT | NO | Soru türü: 'personality', 'skill', 'knowledge' |
| `category` | TEXT | NO | Soru kategorisi: 'numerical', 'verbal', 'logical', 'english', 'personality' |
| `content` | TEXT | NO | Soru metni (HTML/Markdown destekli) |
| `image_url` | TEXT | YES | Resimli sorular için Supabase Storage linki |
| `options` | JSONB | NO | `{"A": "Metin", "B": "Metin", "C": "Metin", "D": "Metin"}` |
| `correct_answer` | TEXT | YES | Doğru şık (A, B, C, D). Kişilik envanterinde NULL |
| `dimension_id` | TEXT | YES | Kişilik envanteri için: 'Dominance', 'Influence', 'Steadiness', 'Conscientiousness' |
| `points` | INT | NO | Bilgi sınavları için ağırlık puanı (Genelde 1, max 10) |
| `difficulty_level` | TEXT | NO | 'easy', 'medium', 'hard' (Yetenek testleri için) |
| `tags` | TEXT[] | YES | Örn: `['flutter', 'mobile']` - arama/filtreleme için |
| `created_by` | UUID | NO | Admin/Recruiter ID - soruyu oluşturan |
| `created_at` | TIMESTAMP | NO | Oluşturulma zamanı |
| `updated_at` | TIMESTAMP | NO | Güncellenme zamanı |

---

## 🗄️ MIGRATION SQL

```sql
-- Supabase: Yeni questions tablosu oluştur
CREATE TABLE questions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  type TEXT NOT NULL CHECK (type IN ('personality', 'skill', 'knowledge')),
  category TEXT NOT NULL CHECK (category IN ('numerical', 'verbal', 'logical', 'english', 'personality')),
  content TEXT NOT NULL,
  image_url TEXT,
  options JSONB NOT NULL DEFAULT '{}'::jsonb,
  correct_answer TEXT,
  dimension_id TEXT,
  points INT NOT NULL DEFAULT 1 CHECK (points >= 1 AND points <= 10),
  difficulty_level TEXT NOT NULL DEFAULT 'medium' CHECK (difficulty_level IN ('easy', 'medium', 'hard')),
  tags TEXT[] DEFAULT '{}',
  created_by UUID NOT NULL REFERENCES profiles(id) ON DELETE RESTRICT,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
  
  -- Constraints
  CONSTRAINT valid_points CHECK (points >= 1 AND points <= 10),
  CONSTRAINT valid_dimensions CHECK (
    type = 'personality' OR dimension_id IS NULL
  )
);

-- Indexes
CREATE INDEX idx_questions_type ON questions(type);
CREATE INDEX idx_questions_category ON questions(category);
CREATE INDEX idx_questions_dimension_id ON questions(dimension_id);
CREATE INDEX idx_questions_created_by ON questions(created_by);
CREATE INDEX idx_questions_tags ON questions USING GIN(tags);

-- Updated At Trigger
CREATE TRIGGER questions_updated_at
BEFORE UPDATE ON questions
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- RLS (Row Level Security)
ALTER TABLE questions ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Sorular herkese gösterilir" ON questions
  FOR SELECT
  USING (true);

CREATE POLICY "Sorular sadece admin/recruiter oluşturabilir" ON questions
  FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE profiles.id = auth.uid()
      AND profiles.role IN ('admin', 'recruiter')
    )
  );

CREATE POLICY "Sorular sadece oluşturan veya admin güncelleyebilir" ON questions
  FOR UPDATE
  USING (
    created_by = auth.uid() OR
    EXISTS (
      SELECT 1 FROM profiles
      WHERE profiles.id = auth.uid()
      AND profiles.role = 'admin'
    )
  );
```

---

## 📝 ÖRNEK VERI

### Örnek 1: Sayısal Yetenek Sorusu

```json
{
  "type": "skill",
  "category": "numerical",
  "content": "Eğer bir ürünün fiyatı 100₺ ise ve %20 indirim uygulanırsa, yeni fiyat kaç lira olur?",
  "options": {
    "A": "80 lira",
    "B": "120 lira",
    "C": "20 lira",
    "D": "100 lira"
  },
  "correct_answer": "A",
  "points": 1,
  "difficulty_level": "easy",
  "tags": ["math", "percentage", "basic"]
}
```

### Örnek 2: İngilizce Sorusu

```json
{
  "type": "skill",
  "category": "english",
  "content": "Choose the correct sentence:",
  "options": {
    "A": "She have gone to the store",
    "B": "She has went to the store",
    "C": "She has gone to the store",
    "D": "She had go to the store"
  },
  "correct_answer": "C",
  "points": 1,
  "difficulty_level": "medium",
  "tags": ["grammar", "present_perfect", "english"]
}
```

### Örnek 3: Mantıksal Akıl Yürütme Sorusu

```json
{
  "type": "skill",
  "category": "logical",
  "content": "Desen: 2, 4, 8, 16, ? - Sonraki sayı kaçtır?",
  "options": {
    "A": "24",
    "B": "32",
    "C": "20",
    "D": "28"
  },
  "correct_answer": "B",
  "points": 1,
  "difficulty_level": "easy",
  "tags": ["sequence", "pattern", "doubling"]
}
```

### Örnek 4: Kişilik Envanteri Sorusu (DISC)

```json
{
  "type": "personality",
  "category": "personality",
  "content": "Bir problem çıktığında, siz:",
  "options": {
    "A": "Hızlı karar alır ve harekete geçerim",
    "B": "İnsanları motivasyonlandırırım ve ekibi motive ederim",
    "C": "Dengeli ve sakin bir şekilde adım atarım",
    "D": "Detaylı analiz yapıp ve doğru çözümü bulurum"
  },
  "correct_answer": null,
  "dimension_id": "Dominance",
  "points": 1,
  "difficulty_level": "medium",
  "tags": ["personality", "disc", "behavior"]
}
```

### Örnek 5: Resimli Soru (Supabase Storage)

```json
{
  "type": "skill",
  "category": "logical",
  "content": "Aşağıdaki şekle göre eksik olan parça hangisidir?",
  "image_url": "https://your-bucket.supabase.co/questions/logical-pattern-5.png",
  "options": {
    "A": "https://your-bucket.supabase.co/questions/option-a.png",
    "B": "https://your-bucket.supabase.co/questions/option-b.png",
    "C": "https://your-bucket.supabase.co/questions/option-c.png",
    "D": "https://your-bucket.supabase.co/questions/option-d.png"
  },
  "correct_answer": "C",
  "points": 2,
  "difficulty_level": "hard",
  "tags": ["visual", "pattern", "reasoning"]
}
```

---

## 🔄 MIGRATION EXCEL → SUPABASE

Eğer mevcut sorularınız var ise, bu script ile import edebilirsiniz:

```python
# Python script: import_questions.py
import pandas as pd
import json
from supabase import create_client, Client

# Supabase bağlantısı
SUPABASE_URL = "your_supabase_url"
SUPABASE_KEY = "your_supabase_key"
supabase: Client = create_client(SUPABASE_URL, SUPABASE_KEY)

# Excel dosyasını oku
df = pd.read_excel('questions.xlsx')

for index, row in df.iterrows():
    # Options JSON'ı oluştur
    options = {
        'A': row['Option_A'],
        'B': row['Option_B'],
        'C': row['Option_C'],
        'D': row['Option_D']
    }
    
    # Veritabanına ekle
    data = {
        'type': row['Type'],
        'category': row['Category'],
        'content': row['Content'],
        'image_url': row.get('Image_URL') or None,
        'options': options,
        'correct_answer': row.get('Correct_Answer'),
        'dimension_id': row.get('Dimension_ID'),
        'points': row.get('Points', 1),
        'difficulty_level': row.get('Difficulty_Level', 'medium'),
        'tags': row.get('Tags', '').split(',') if row.get('Tags') else [],
        'created_by': 'admin-uuid-here'
    }
    
    response = supabase.table('questions').insert(data).execute()
    print(f"Row {index + 1} inserted: {response.data[0]['id']}")

print("Import tamamlandı!")
```

---

## 🎯 QUESTIONS TABLO KULLANIM SENARYOLARI

### 1. Sayısal Yetenek Testi
```dart
// Test al
final questions = await _supabase
  .from('questions')
  .select()
  .eq('type', 'skill')
  .eq('category', 'numerical')
  .eq('difficulty_level', 'medium')
  .limit(10);
```

### 2. Kişilik Envanteri (DISC)
```dart
// DISC soruları al
final discQuestions = await _supabase
  .from('questions')
  .select()
  .eq('type', 'personality')
  .in('dimension_id', ['Dominance', 'Influence', 'Steadiness', 'Conscientiousness'])
  .limit(40);
```

### 3. Özel Filtreleme (Tags)
```dart
// Flutter yetenek testleri
final flutterQuestions = await _supabase
  .from('questions')
  .select()
  .eq('type', 'skill')
  .filter('tags', 'cs', ['flutter', 'dart']);
```

---

## ⚠️ ÖNEMLI NOTLAR

1. **Kişilik Envanteri**: `correct_answer` NULL olmalı (değerlendirilmiş puanlanmaz)
2. **Bilgi Testleri**: `correct_answer` SET olmalı (otomatik puanlanır)
3. **Resimli Sorular**: Her resim Supabase Storage'da barındırılmalı
4. **Güvenlik**: RLS ilkeleri admin/recruiter'ların soru oluşturmasını kısıtlar
5. **Etiketleme**: Tags ile test kategorilerine göre dinamik filtreleme mümkün

---

## 📊 VERITABANI OPTIMIZASYONU

Sorular tablosu çok sayıda sorgu alacağı için:

```sql
-- Composite Index (sık kullanılan kombinasyonlar)
CREATE INDEX idx_questions_type_category
ON questions(type, category);

CREATE INDEX idx_questions_category_difficulty
ON questions(category, difficulty_level);

-- JSON Path Index (options içinde arama)
CREATE INDEX idx_questions_options
ON questions USING GIN(options);
```

---

## 🔄 GÜNCELLEME İŞLEMLeri

Sorular tekrar tekrar güncellenebilir (admin tarafından):

```dart
// Soruyu güncelle
await _supabase
  .from('questions')
  .update({
    'content': 'Yeni soru metni',
    'difficulty_level': 'hard',
    'tags': ['updated', 'flutter'],
  })
  .eq('id', questionId)
  .execute();

// `updated_at` trigger otomatik olarak günceller
```
