import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/theme/app_text_styles.dart';
import 'package:easy_pay_app/core/widgets/custom_app_bar.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:easy_pay_app/features/setting/presentation/widgets/setting_row_item.dart';
import 'package:flutter/material.dart';

class AppInformationScreen extends StatelessWidget {
  const AppInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: "app_information".tr(),
      ),
      body: Padding(
        padding: EdgeInsets.all(context.scaleWidth(24.0)),
        child: Column(
          children: [
            Text(
              "cabank_name".tr(),
              style: AppTextStyles.titleLarge.copyWith(
                fontSize: context.scaleWidth(AppTextStyles.titleLarge.fontSize ?? 22),
              ),
            ),
            SizedBox(
              height: context.scaleHeight(28),
            ),
            SettingRowItem(
              title: "date_of_manufacture".tr(),
              showArrow: false,
              trailing: Text(
                "dec_2019".tr(),
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: context.scaleWidth(14),
                ),
              ),
            ),
            SettingRowItem(
              title: "version".tr(),
              showArrow: false,
              trailing: Text(
                "v_9_0_2".tr(),
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: context.scaleWidth(14),
                ),
              ),
            ),
            SettingRowItem(
              title: "language".tr(),
              showArrow: false,
              trailing: Text(
                "english".tr(),
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: context.scaleWidth(14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
