import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/constants/app_assets.dart';
import 'package:easy_pay_app/features/bottomNav/presentation/widgets/bottom_nav_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_pay_app/core/core.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final List<BottomNavItem> items = const [
    BottomNavItem(
      icon: AppAssets.homeIcon,
      activeIcon: AppAssets.homeActiveIcon,
      title: "home",
    ),
    BottomNavItem(
      icon: AppAssets.searchIcon,
      activeIcon: AppAssets.searchActiveIcon,
      title: "search",
    ),
    BottomNavItem(
      icon: AppAssets.emailIcon,
      activeIcon: AppAssets.emailActiveIcon,
      title: "message",
    ),
    BottomNavItem(
      icon: AppAssets.settingIcon,
      activeIcon: AppAssets.settingActiveIcon,
      title: "setting",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).bottomNavigationBarTheme.backgroundColor ??
            AppColors.background,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5),
            blurRadius: 10,
            offset: const Offset(0, -2),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          items.length,
          (index) {
            final isSelected = currentIndex == index;
            return InkWell(
              onTap: () => onTap(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      isSelected ? items[index].activeIcon : items[index].icon,
                    ),
                    if (isSelected) ...[
                      const SizedBox(width: 8),
                      Text(
                        items[index].title.tr(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
