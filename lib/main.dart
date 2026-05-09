import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';
import 'screens/login_screen.dart';
import 'screens/hr_dashboard_screen.dart';
import 'services/database_service.dart';

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

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 900) {
            return const HrDashboardScreen();
          } else {
            return const LoginScreen();
          }
        },
      ),
    ),
    GoRoute(
      path: '/recruiter',
      builder: (context, state) => const HrDashboardScreen(),
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
