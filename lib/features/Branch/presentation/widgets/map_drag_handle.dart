import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class MapDragHandle extends StatelessWidget {
  const MapDragHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Container(
          width: 40,
          height: 5,
          decoration: BoxDecoration(
            color: AppColors.gray,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}