import 'package:easy_pay_app/core/core.dart';
import 'package:easy_pay_app/features/bottomNav/home/presentation/screens/home_screen.dart';
import 'package:easy_pay_app/features/bottomNav/message/presentation/screens/message_screen.dart';
import 'package:easy_pay_app/features/bottomNav/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:easy_pay_app/features/bottomNav/setting/presentation/screens/setting_screen.dart';
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
    Placeholder(), // SearchScreen()
    MessageScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
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