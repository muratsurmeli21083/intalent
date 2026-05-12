import 'dart:convert';
import 'package:http/http.dart' as http;

class AiService {
  // Not: Gerçek projede API Key'ler environment variable'da tutulmalıdır.
  static const String _apiKey = 'YOUR_API_KEY_HERE'; // Buraya kendi anahtarını eklemelisin
  static const String _baseUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent';

  static Future<String> getCoachingResponse(List<Map<String, String>> history) async {
    try {
      // Mesaj geçmişini Gemini formatına çeviriyoruz
      final contents = history.map((msg) {
        return {
          'role': msg['role'] == 'user' ? 'user' : 'model',
          'parts': [{'text': msg['content']}]
        };
      }).toList();

      // Master Prompt (Sistem Talimatı)
      final systemInstruction = {
        'role': 'user',
        'parts': [{
          'text': "Sen profesyonel bir Liderlik Koçusun (PCC seviyesinde). Adler ve Gestalt ekollerini kullanıyorsun. "
                  "Görevin öğüt vermek değil, güçlü sorular sorarak farkındalık yaratmaktır. "
                  "Kısa ve öz konuş. Asla liste yapma. Tek seferde tek bir derin soru sor. "
                  "Kullanıcının duygularını yansıt (Reflecting)."
        }]
      };

      // Başa sistem talimatını ekleyerek gönderiyoruz (Gemini Flash için pratik yöntem)
      final response = await http.post(
        Uri.parse('$_baseUrl?key=$_apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [systemInstruction, ...contents],
          'generationConfig': {
            'temperature': 0.7,
            'maxOutputTokens': 300,
          }
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['candidates'][0]['content']['parts'][0]['text'];
      } else {
        return "Şu an bağlantıda bir sorun yaşıyorum. Biraz sonra tekrar deneyebilir misin?";
      }
    } catch (e) {
      return "Bir hata oluştu: $e";
    }
  }
}
