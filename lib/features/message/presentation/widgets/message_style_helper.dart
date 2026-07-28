import 'package:flutter/material.dart';
import 'package:easy_pay_app/core/constants/app_assets.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';

class MessageStyleHelper {
  static Map<String, dynamic> getDetails(int index) {
    switch (index % 5) {
      case 0:
        return {
          'icon': AppAssets.bankIcon,
          'color': AppColors.primary,
          'date': 'Today',
        };
      case 1:
        return {
          'icon': AppAssets.accountIcon,
          'color': AppColors.messagePink,
          'date': '12/10',
        };
      case 2:
        return {
          'icon': AppAssets.alertIcon,
          'color': AppColors.messageBlue,
          'date': '11/10',
        };
      case 3:
        return {
          'icon': AppAssets.paypalIcon,
          'color': AppColors.messageOrange,
          'date': '10/11',
        };
      default:
        return {
          'icon': AppAssets.withdrawIcon,
          'color': AppColors.messageTeal,
          'date': '10/12',
        };
    }
  }
}