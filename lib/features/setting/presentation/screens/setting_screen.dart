import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/constants/app_assets.dart';
import 'package:easy_pay_app/core/routes/app_routes_name.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/widgets/header_widget.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:easy_pay_app/features/setting/presentation/widgets/setting_row_item.dart';
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
            title: 'setting'.tr(),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context, AppRoutesName.mainScreen);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: context.scaleHeight(60)),
          Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(context.scaleWidth(30)),
                      topRight: Radius.circular(context.scaleWidth(30)),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Space for avatar
                      SizedBox(height: context.scaleHeight(72)),
                      // User name
                      Text(
                        'Push Puttichai',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: context.scaleWidth(16),
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                          height: 1.5,
                        ),
                      ),

                      SizedBox(height: context.scaleHeight(24)),

                      // Settings list
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: context.scaleWidth(24)),
                        child: Column(
                          children: [
                            SettingRowItem(
                              title: 'password'.tr(),
                              onTap: () {},
                            ),
                            SettingRowItem(
                              title: 'touch_id'.tr(),
                              onTap: () {},
                            ),
                            SettingRowItem(
                              title: 'languages'.tr(),
                              onTap: () {},
                            ),
                            SettingRowItem(
                              title: 'app_information'.tr(),
                              onTap: () {
                                Navigator.pushNamed(context,
                                    AppRoutesName.appInformationScreen);
                              },
                            ),
                            SettingRowItem(
                              title: 'customer_care'.tr(),
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
                  top: -context.scaleHeight(50),
                  left: 0,
                  right: 0,
                  child: Center(
                    child: ClipOval(
                      child: Image.asset(
                        AppAssets.avatarImage,
                        width: context.scaleWidth(100),
                        height: context.scaleHeight(100),
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
