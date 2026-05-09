import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/login_screen.dart';
import 'screens/hr_dashboard_screen.dart';

// TODO: Replace with your actual Supabase URL and Anon Key
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

class InTalentApp extends StatelessWidget {
  const InTalentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InTalent',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF003EC7),
          primary: const Color(0xFF003EC7),
          secondary: const Color(0xFF666666),
          surface: Colors.white,
        ),
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 900) {
            return const HrDashboardScreen();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
