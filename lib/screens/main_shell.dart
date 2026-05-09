import 'package:flutter/material.dart';
import 'analysis_screen.dart';
import 'profile_screen.dart';
import 'discover_screen.dart';
import 'ai_coach_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DiscoverScreen(),
    const AnalysisScreen(),
    const AiCoachScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF003EC7),
        unselectedItemColor: const Color(0xFF666666),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Keşfet'),
          BottomNavigationBarItem(icon: Icon(Icons.science_outlined), label: 'Analiz'),
          BottomNavigationBarItem(icon: Icon(Icons.auto_awesome_outlined), label: 'AI Coach'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profil'),
        ],
      ),
    );
  }
}
