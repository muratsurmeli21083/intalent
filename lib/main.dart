import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';
import 'screens/login_screen.dart';
import 'screens/hr_dashboard_screen.dart';
import 'screens/main_shell.dart';
import 'screens/job_wizard_screen.dart';
import 'screens/ai_coach_screen.dart';
import 'screens/onboarding_screen.dart';

const String supabaseUrl = 'sb_publishable__EzbBggvn5vbfuos7OD7Gg_1t8xIWfe';
const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBuc2l6dXFhY2Z3ZWVuY2R2b2loIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzgzNDEyMDUsImV4cCI6MjA5MzkxNzIwNX0.DzJVXPohni3EhDdg4xZ5fARxl7DjSuuElXYZF9pMyuM';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
  runApp(const InTalentApp());
}

// GLOBAL ROUTER
final GoRouter router = GoRouter(
  initialLocation: '/splash', // KESİN BAŞLANGIÇ NOKTASI
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/candidate-home',
      builder: (context, state) => const MainShell(),
    ),
    GoRoute(
      path: '/recruiter',
      builder: (context, state) => const HrDashboardScreen(),
    ),
    GoRoute(
      path: '/job-wizard',
      builder: (context, state) => const JobWizardScreen(),
    ),
  ],
);

class InTalentApp extends StatelessWidget {
  const InTalentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'InTalent SaaS',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4B3091)),
        scaffoldBackgroundColor: const Color(0xFFF9F9FB),
      ),
    );
  }
}
