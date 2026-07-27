import 'package:easy_pay_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class AuthFooter extends StatelessWidget {
  final String title;
  final String actionText;
  final String routeName;

  const AuthFooter({
    super.key,
    required this.title,
    required this.actionText,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: AppTextStyles.bodyMediumDark,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, routeName);
            },
            child: Text(
              actionText,
              style: AppTextStyles.titleSmallPrimary,
            ),
          ),
        ],
      ),
    );
  }
}