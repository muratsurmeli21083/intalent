import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';
import 'screens/login_screen.dart';
import 'screens/hr_dashboard_screen.dart';

// Supabase Yapılandırması
const String supabaseUrl = 'sb_publishable__EzbBggvn5vbfuos7OD7Gg_1t8xIWfe';
const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBuc2l6dXFhY2Z3ZWVuY2R2b2loIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzgzNDEyMDUsImV4cCI6MjA5MzkxNzIwNX0.DzJVXPohni3EhDdg4xZ5fARxl7DjSuuElXYZF9pMyuM';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );
  
  runApp(const InTalentApp());
}

// KESİN ROTALAR (GoRouter)
final _router = GoRouter(
  initialLocation: '/', // Uygulama ana giriş kapısı: Aday Girişi
  debugLogDiagnostics: true, // Hataları konsolda görmek için
  routes: [
    // --- ADAY PORTALI (Root) ---
    GoRoute(
      path: '/',
      name: 'candidate_login',
      builder: (context, state) => const LoginScreen(),
    ),
    
    // --- İK PORTALI ---
    GoRoute(
      path: '/recruiter',
      name: 'hr_dashboard',
      builder: (context, state) => const HrDashboardScreen(),
    ),
  ],
  // Hata durumunda ana sayfaya dön
  errorBuilder: (context, state) => const LoginScreen(),
);

class InTalentApp extends StatelessWidget {
  const InTalentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'InTalent SaaS',
      debugShowCheckedModeBanner: false,
      // GoRouter Ayarları
      routerConfig: _router,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF003EC7),
          primary: const Color(0xFF003EC7),
        ),
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
      ),
    );
  }
}
