import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/colors.dart';
import '../../../core/utils/localization.dart';
import '../challenges/challenges_page.dart';
import '../home/home_page.dart';
import '../leaderboard/leaderboard_page.dart';
import '../profile/profile_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const ChallengesPage(),
    const LeaderboardPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.textCaption.withAlpha(20), width: 0.5)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            HapticFeedback.lightImpact(); // Micro-interaction
            setState(() => _currentIndex = index);
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: l10n.home),
            BottomNavigationBarItem(icon: Icon(Icons.rocket_outlined), activeIcon: Icon(Icons.rocket), label: l10n.explore),
            BottomNavigationBarItem(icon: Icon(Icons.leaderboard_outlined), activeIcon: Icon(Icons.leaderboard), label: l10n.board),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: l10n.profile),
          ],
        ),
      ),
    );
  }
}
