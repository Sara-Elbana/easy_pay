import 'package:easy_pay_app/features/bottomNav/presentation/screens/home_screen.dart';
import 'package:easy_pay_app/features/bottomNav/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:easy_pay_app/features/bottomNav/presentation/screens/search_screen.dart';
import 'package:flutter/material.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    SearchScreen(),
    Placeholder(), // EmailScreen()
    Placeholder(), // SettingScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}