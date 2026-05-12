import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  bool _isLogin = true;
  bool _isLoading = false;
  bool _obscure = true;

  final _supabase = Supabase.instance.client;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  Future<void> _handleEmailAuth() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      _showError('E-posta ve şifre alanları boş bırakılamaz.');
      return;
    }

    setState(() => _isLoading = true);
    try {
      if (_isLogin) {
        // --- GİRİŞ YAP ---
        final res = await _supabase.auth.signInWithPassword(email: email, password: password);
        if (res.user == null) throw 'Giriş başarısız. Bilgilerinizi kontrol edin.';
        _redirectUser(res.user!);
      } else {
        // --- KAYIT OL ---
        final firstName = _firstNameController.text.trim();
        final lastName = _lastNameController.text.trim();
        if (firstName.isEmpty || lastName.isEmpty) {
          _showError('Ad ve soyad alanları zorunludur.');
          setState(() => _isLoading = false);
          return;
        }

        try {
          final res = await _supabase.auth.signUp(
            email: email,
            password: password,
            data: {'first_name': firstName, 'last_name': lastName, 'role': 'candidate'},
          );

          if (res.user != null) {
            // Profil kaydı oluştur
            try {
              await _supabase.from('profiles').upsert({
                'id': res.user!.id,
                'email': email,
                'first_name': firstName,
                'last_name': lastName,
                'role': 'candidate',
              }).select();
              
              if (mounted) {
                _showSuccess('Kayıt başarılı! Lütfen e-postanızı doğrulayın ve giriş yapın.');
                setState(() => _isLogin = true);
              }
            } catch (profileError) {
              print('Profil oluşturma hatası: $profileError');
              if (mounted) {
                _showError('Profil oluşturulurken hata oluştu: $profileError');
              }
            }
          } else {
            _showError('Kayıt başarısız oldu. Lütfen tekrar deneyin.');
          }
        } catch (signupError) {
          print('Sign up hatası: $signupError');
          if (mounted) {
            _showError('Kayıt sırasında hata oluştu: $signupError');
          }
        }
      }
    } on AuthException catch (e) {
      _showError(_translateAuthError(e.message));
    } catch (e) {
      print('Beklenmeyen hata: $e');
      _showError('Bir hata oluştu: ${e.toString()}');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _handleGoogleLogin() async {
    setState(() => _isLoading = true);
    try {
      await _supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'io.supabase.intalent://login-callback',
      );
      // OAuth akışı tamamlandığında onAuthStateChange dinleyicisi tetiklenecek
    } catch (e) {
      _showError('Google ile giriş başarısız: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _handleLinkedInLogin() async {
    setState(() => _isLoading = true);
    try {
      await _supabase.auth.signInWithOAuth(
        OAuthProvider.linkedin,
        redirectTo: 'io.supabase.intalent://login-callback',
      );
      // OAuth akışı tamamlandığında onAuthStateChange dinleyicisi tetiklenecek
    } catch (e) {
      _showError('LinkedIn ile giriş başarısız: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _redirectUser(User user) {
    // Kullanıcı rolüne göre yönlendir
    final role = user.userMetadata?['role'] ?? 'candidate';
    if (role == 'admin' || role == 'recruiter') {
      context.go('/recruiter');
    } else {
      context.go('/candidate-home');
    }
  }

  String _translateAuthError(String msg) {
    if (msg.contains('Invalid login credentials')) return 'Hatalı e-posta veya şifre.';
    if (msg.contains('Email not confirmed')) return 'E-posta adresinizi henüz doğrulamadınız.';
    if (msg.contains('User already registered')) return 'Bu e-posta zaten kayıtlı. Giriş yapmayı deneyin.';
    if (msg.contains('Password should be')) return 'Şifre en az 6 karakter olmalıdır.';
    return msg;
  }

  void _showError(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: Colors.red.shade700,
      behavior: SnackBarBehavior.floating,
    ));
  }

  void _showSuccess(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: Colors.green.shade700,
      behavior: SnackBarBehavior.floating,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 48),
              // Logo
              Container(
                width: 72, height: 72,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFF001A6B), Color(0xFF003EC7)]),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.psychology_rounded, color: Colors.white, size: 36),
              ),
              const SizedBox(height: 20),
              Text('intalent',
                style: GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.w900, color: const Color(0xFF003EC7), letterSpacing: -1.5)),
              const SizedBox(height: 40),

              // --- GOOGLE LOGIN ---
              _buildGoogleButton(),
              const SizedBox(height: 12),
              // --- LINKEDIN LOGIN ---
              _buildLinkedInButton(),
              const SizedBox(height: 20),
              _buildDivider(),
              const SizedBox(height: 20),

              // --- FORM ---
              if (!_isLogin) ...[
                Row(
                  children: [
                    Expanded(child: _buildTextField(_firstNameController, 'Ad', Icons.person_outline)),
                    const SizedBox(width: 12),
                    Expanded(child: _buildTextField(_lastNameController, 'Soyad', Icons.person_outline)),
                  ],
                ),
                const SizedBox(height: 14),
              ],
              _buildTextField(_emailController, 'E-posta', Icons.email_outlined, keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 14),
              _buildPasswordField(),
              const SizedBox(height: 28),

              // --- SUBMIT ---
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleEmailAuth,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF003EC7),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  child: _isLoading
                    ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                    : Text(_isLogin ? 'Giriş Yap' : 'Kayıt Ol', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                ),
              ),

              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_isLogin ? 'Hesabın yok mu?' : 'Zaten hesabın var mı?', style: TextStyle(color: Colors.grey[600])),
                  TextButton(
                    onPressed: () => setState(() => _isLogin = !_isLogin),
                    child: Text(_isLogin ? 'Kayıt Ol' : 'Giriş Yap',
                      style: const TextStyle(color: Color(0xFF003EC7), fontWeight: FontWeight.w700)),
                  ),
                ],
              ),

              const SizedBox(height: 8),
              // Debug / Recruiter
              TextButton.icon(
                onPressed: () => context.go('/recruiter'),
                icon: const Icon(Icons.admin_panel_settings_outlined, color: Colors.grey, size: 16),
                label: const Text('İK Paneline Git', style: TextStyle(color: Colors.grey, fontSize: 12)),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleButton() {
    return OutlinedButton(
      onPressed: _isLoading ? null : _handleGoogleLogin,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 54),
        side: const BorderSide(color: Color(0xFFE0E3E5), width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        backgroundColor: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.g_mobiledata, size: 22, color: Color(0xFF4285F4)),
          const SizedBox(width: 12),
          const Text('Google ile Devam Et', style: TextStyle(color: Color(0xFF191C1E), fontWeight: FontWeight.w600, fontSize: 15)),
        ],
      ),
    );
  }

  Widget _buildLinkedInButton() {
    return OutlinedButton(
      onPressed: _isLoading ? null : _handleLinkedInLogin,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 54),
        side: const BorderSide(color: Color(0xFFE0E3E5), width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        backgroundColor: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: const Color(0xFF0077B5),
              borderRadius: BorderRadius.circular(3),
            ),
            child: const Center(
              child: Text('in', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(width: 12),
          const Text('LinkedIn ile Devam Et', style: TextStyle(color: Color(0xFF191C1E), fontWeight: FontWeight.w600, fontSize: 15)),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        const Expanded(child: Divider(color: Color(0xFFE0E3E5))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text('veya e-posta ile', style: TextStyle(color: Colors.grey[500], fontSize: 13)),
        ),
        const Expanded(child: Divider(color: Color(0xFFE0E3E5))),
      ],
    );
  }

  Widget _buildTextField(TextEditingController ctrl, String hint, IconData icon, {TextInputType? keyboardType}) {
    return TextField(
      controller: ctrl,
      keyboardType: keyboardType,
      enabled: true,
      readOnly: false,
      style: const TextStyle(fontSize: 15, color: Color(0xFF191C1E)),
      cursorColor: const Color(0xFF003EC7),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[400]),
        prefixIcon: Icon(icon, color: Colors.grey[400], size: 20),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE0E3E5))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE0E3E5))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF003EC7), width: 1.5)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      controller: _passwordController,
      obscureText: _obscure,
      enabled: true,
      readOnly: false,
      style: const TextStyle(fontSize: 15, color: Color(0xFF191C1E)),
      cursorColor: const Color(0xFF003EC7),
      decoration: InputDecoration(
        hintText: 'Şifre',
        hintStyle: TextStyle(color: Colors.grey[400]),
        prefixIcon: Icon(Icons.lock_outline, color: Colors.grey[400], size: 20),
        suffixIcon: IconButton(
          icon: Icon(_obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: Colors.grey[400], size: 20),
          onPressed: () => setState(() => _obscure = !_obscure),
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE0E3E5))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE0E3E5))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF003EC7), width: 1.5)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }
}
