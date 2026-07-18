import 'package:easy_pay_app/core/constants/app_assets.dart';
import 'package:easy_pay_app/core/routes/app_routes_name.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/widgets/header_widget.dart';
import 'package:easy_pay_app/features/bottomNav/setting/presentation/widgets/setting_row_item.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        children: [
          HeaderWidget(
            title: 'Setting',
            leading: IconButton(
              onPressed: (){Navigator.pop(context,AppRoutesName.mainScreen);},
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 60),
          Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Space for avatar
                      const SizedBox(height: 72),
                      // User name
                      const Text(
                        'Push Puttichai',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Settings list
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          children: [
                            SettingRowItem(
                              title: 'Password',
                              onTap: () {},
                            ),
                            SettingRowItem(
                              title: 'Touch ID',
                              onTap: () {},
                            ),
                            SettingRowItem(
                              title: 'Languages',
                              onTap: () {},
                            ),
                            SettingRowItem(
                              title: 'App information',
                              onTap: () {
                                Navigator.pushNamed(context, AppRoutesName.appInformationScreen);
                              },
                            ),
                            SettingRowItem(
                              title: 'Customer care',
                              subtitle: '19008989',
                              onTap: () {},
                              showArrow: false,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Avatar overlapping the header and white card
                Positioned(
                  top: -50,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: ClipOval(
                      child: Image.asset(
                        AppAssets.avatarImage,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
