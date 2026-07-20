import 'dart:io';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  final String? url;
  final String? name;
  final double radius;
  final IconData defaultIcon;
  final Color? backgroundColor;

  const CustomAvatar({
    super.key,
    required this.url,
    this.name,
    required this.radius,
    this.defaultIcon = Icons.person,
    this.backgroundColor,
  });

  ImageProvider? _getAvatarImage(String? url) {
    if (url == null || url.trim().isEmpty) return null;
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return NetworkImage(url);
    }
    return FileImage(File(url));
  }

  @override
  Widget build(BuildContext context) {
    final image = _getAvatarImage(url);

    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor ?? AppColors.circleBackdrop,
      backgroundImage: image,
      child: image == null
          ? (name != null && name!.trim().isNotEmpty
              ? Text(
                  name!.substring(0, 1).toUpperCase(),
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: radius * 0.9,
                  ),
                )
              : Icon(
                  defaultIcon,
                  size: radius * 1.0,
                  color: AppColors.primary,
                ))
          : null,
    );
  }
}
