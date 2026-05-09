import 'package:flutter/material.dart';
import 'main_shell.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              // Logo Placeholder
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFF003EC7),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(Icons.auto_awesome, color: Colors.white, size: 40),
              ),
              const SizedBox(height: 24),
              const Text(
                'InTalent',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF003EC7),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'AI Destekli Kariyer Yolculuğun',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF666666),
                ),
              ),
              const SizedBox(height: 48),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'E-posta Adresiniz',
                  prefixIcon: Icon(Icons.email_outlined, size: 20),
                ),
              ),
              const SizedBox(height: 16),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Şifreniz',
                  prefixIcon: Icon(Icons.lock_outline, size: 20),
                  suffixIcon: Icon(Icons.visibility_off_outlined, size: 20),
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Şifremi Unuttum',
                    style: TextStyle(color: Color(0xFF003EC7)),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MainShell()),
                  );
                },
                child: const Text('Giriş Yap', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 24),
              const Row(
                children: [
                  Expanded(child: Divider(color: Color(0xFFEEEEEE))),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('veya', style: TextStyle(color: Color(0xFF999999))),
                  ),
                  Expanded(child: Divider(color: Color(0xFFEEEEEE))),
                ],
              ),
              const SizedBox(height: 24),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  side: const BorderSide(color: Color(0xFFEEEEEE)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.linked_camera, color: Color(0xFF0077B5), size: 20), // Placeholder for LinkedIn icon
                    SizedBox(width: 12),
                    Text('LinkedIn ile Devam Et', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Hesabınız yok mu?'),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Kayıt Ol', style: TextStyle(color: Color(0xFF003EC7), fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
