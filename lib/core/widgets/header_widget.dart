import 'package:flutter/material.dart';
import 'package:easy_pay_app/core/theme/app_text_styles.dart';

class HeaderWidget extends StatelessWidget {
  final Widget? leading;
  final String title;
  final Widget? trailing;

  const HeaderWidget({
    super.key,
    required this.title,
    this.leading,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.paddingOf(context).top;
    return Container(
      padding: EdgeInsets.only(
        top: statusBarHeight + 10,
        bottom: 16,
        left: 16,
        right: 16,
      ),
      child: Row(
        children: [
          leading ?? const SizedBox(width: 40),
          SizedBox(width: leading != null ? 16 : 0),
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.titleLargeWhite,
            ),
          ),
          trailing ?? const SizedBox(width: 40),
        ],
      ),
    );
  }
}
