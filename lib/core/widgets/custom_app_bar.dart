import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leading;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final bool centerTitle;
  final Color? backgroundColor;
  final IconData? leadingIcon;
  final double? leadingIconSize;

  const CustomAppBar({
    super.key,
    this.title,
    this.leading,
    this.onBackPressed,
    this.actions,
    this.centerTitle = false,
    this.backgroundColor,
    this.leadingIcon,
    this.leadingIconSize,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget? leadingWidget = leading;
    if (leadingWidget == null) {
      final bool canPop = Navigator.canPop(context);
      if (onBackPressed != null || canPop) {
        leadingWidget = IconButton(
          icon: Icon(
            leadingIcon ?? Icons.arrow_back_ios_new,
            color: theme.iconTheme.color ?? AppColors.textDark,
            size: leadingIconSize,
          ),
          onPressed: onBackPressed ?? () => Navigator.pop(context),
        );
      }
    }

    return AppBar(
      backgroundColor: AppColors.white ,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: leadingWidget,
      title: title != null
          ? Text(
        title!,
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ) ??
            const TextStyle(
              color: AppColors.textDark,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
      )
          : null,
      centerTitle: centerTitle,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}