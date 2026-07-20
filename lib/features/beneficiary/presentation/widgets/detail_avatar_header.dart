import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:easy_pay_app/core/widgets/custom_avatar.dart';
import 'package:flutter/material.dart';

class DetailAvatarHeader extends StatelessWidget implements PreferredSizeWidget {
  final String? avatarUrl;
  final String name;
  final VoidCallback onEdit;
  final VoidCallback onBack;

  const DetailAvatarHeader({
    super.key,
    required this.avatarUrl,
    required this.name,
    required this.onEdit,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: onBack,
          ),
          title: Text(
            'beneficiary'.tr(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.white),
              onPressed: onEdit,
            ),
          ],
        ),
        SizedBox(height: context.scaleHeight(16)),
        CustomAvatar(
          url: avatarUrl,
          name: name.isEmpty ? null : name,
          radius: 60,
        ),
        SizedBox(height: context.scaleHeight(12)),
        Text(
          name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(250);
}
