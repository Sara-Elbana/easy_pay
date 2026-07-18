import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/theme/app_text_styles.dart';
import 'package:easy_pay_app/core/widgets/custom_app_bar.dart';
import 'package:easy_pay_app/features/bottomNav/setting/presentation/widgets/setting_row_item.dart';
import 'package:flutter/material.dart';

class AppInformationScreen extends StatelessWidget {
  const AppInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: "App information",
      ),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(
              "CaBank E-mobile Banking",
              style: AppTextStyles.titleLarge,
            ),
            SizedBox(
              height: 28,
            ),
            SettingRowItem(
              title: "Date of manufacture",
              showArrow: false,
              trailing: Text(
                "Dec 2019",
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SettingRowItem(
              title: "Version",
              showArrow: false,
              trailing: Text(
                "9.0.2",
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ), SettingRowItem(
              title: "Language",
              showArrow: false,
              trailing: Text(
                "English",
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
