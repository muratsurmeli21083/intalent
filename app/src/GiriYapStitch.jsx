import 'package:flutter/material.dart';

class GiriYapScreen extends StatelessWidget {
  const GiriYapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Subtle Tech Background Overlay (Pattern simulation)
          Positioned.fill(
            child: Opacity(
              opacity: 0.03,
              child: Image.network(
                'https://www.transparenttextures.com/patterns/carbon-fibre.png',
                repeat: ImageRepeat.repeat,
              ),
            ),
          ),
          // Decorative Soft Gradients
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF003EC7).withOpacity(0.05),
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            left: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFD2E0FE).withOpacity(0.2),
              ),
            ),
          ),
          
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  // Logo Section
                  Column(
                    children: [
                      Image.network(
                        'https://lh3.googleusercontent.com/aida/ADBb0ui6KVrYrRA7U3VTA5a-FEciPyigrd2NoJpc8hnw5Bcs1mWiiosaWDEhUq86TfR0qA7C434myFIK1u6baB-es8yI9TqQs-d3jepof49qNDAirjRYC1L1c69z9KxYtwtGObwm_QrEQC5iozsBrflGl-0Mcdz89grGB0-A-sUDcJ0JqYV2mU5HnhvrhTSuhkV80JUCDqpyWva3Nr7XoSpKLsJXCuaV3CfFRp0rPwOIyQUDdAwjYzax9hHSkhUkvJXQoNy73V8o4rY2',
                        width: 128,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'intalent',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -1,
                          color: Color(0xFF191C1E),
                        ),
                      ),
                      const Text(
                        'Geleceğin Yetenek Laboratuvarı',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF434656),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),
                  
                  // Login Card
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Hoş Geldiniz',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF191C1E),
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Lütfen profesyonel hesabınızla giriş yapın.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF434656),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        
                        // LinkedIn Button
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const PreferencesScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF003EC7),
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.link, size: 20),
                              const SizedBox(width: 8),
                              const Text(
                                'LinkedIn ile Bağlan',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        
                        // Divider
                        Row(
                          children: [
                            Expanded(child: Divider(color: const Color(0xFFC3C5D9))),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                'VEYA',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF737688),
                                ),
                              ),
                            ),
                            Expanded(child: Divider(color: const Color(0xFFC3C5D9))),
                          ],
                        ),
                        const SizedBox(height: 24),
                        
                        // Email Input
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'E-posta ile devam edin',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF434656),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'E-posta adresiniz',
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Color(0xFFC3C5D9)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Color(0xFFC3C5D9)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        // Password Input
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Şifre',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF434656),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Şifreniz',
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFFC3C5D9)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFFC3C5D9)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        
                        // Continue Button
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const PreferencesScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF515F78),
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Devam Et',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        
                        // Consent
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Checkbox(value: false, onChanged: (v) {}),
                            const Expanded(
                              child: Text(
                                'Kullanım koşullarını ve KVKK onayı metnini okudum, kabul ediyorum.',
                                style: TextStyle(fontSize: 12, color: Color(0xFF434656)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 48),
                  // Footer Visual
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.verified_user, size: 18, color: Color(0xFF737688)),
                      SizedBox(width: 4),
                      Text('GÜVENLİ ALTYAPI', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF737688))),
                      SizedBox(width: 16),
                      Icon(Icons.analytics, size: 18, color: Color(0xFF737688)),
                      SizedBox(width: 4),
                      Text('VERİ ODAKLI', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF737688))),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
