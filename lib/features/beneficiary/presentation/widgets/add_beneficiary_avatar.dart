import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:easy_pay_app/core/widgets/custom_avatar.dart';
import 'package:flutter/material.dart';

class AddBeneficiaryAvatar extends StatelessWidget {
  final String? avatarUrl;
  final String name;
  final VoidCallback onPickImage;

  const AddBeneficiaryAvatar({
    super.key,
    required this.avatarUrl,
    required this.name,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Stack(
            children: [
              CustomAvatar(
                url: avatarUrl,
                name: name.isEmpty ? null : name,
                radius: 60,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.primary,
                  child: IconButton(
                    icon: const Icon(Icons.camera_alt, size: 16, color: Colors.white),
                    onPressed: onPickImage,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: context.scaleHeight(12)),
        Text(
          name.isEmpty ? 'Push Puttichai' : name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
