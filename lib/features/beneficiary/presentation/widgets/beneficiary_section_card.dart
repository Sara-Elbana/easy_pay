import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:easy_pay_app/core/widgets/custom_avatar.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/beneficiary.dart';

class BeneficiarySectionCard extends StatelessWidget {
  final String title;
  final List<Beneficiary> items;
  final ValueChanged<Beneficiary> onTap;

  const BeneficiarySectionCard({
    super.key,
    required this.title,
    required this.items,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.gray,
          ),
        ),
        SizedBox(height: context.scaleHeight(8)),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Color(0x123629B7),
                offset: Offset(0, 4),
                blurRadius: 30,
              ),
            ],
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (context, index) => const Divider(
              color: Color(0xFFECECEC),
              height: 1,
            ),
            itemBuilder: (context, index) {
              final b = items[index];
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: CustomAvatar(
                  url: b.avatarUrl,
                  name: b.name,
                  radius: 20,
                ),
                title: Text(
                  b.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textDark,
                  ),
                ),
                subtitle: Text(
                  b.cardNumber,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.gray,
                  ),
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: AppColors.textLight,
                ),
                onTap: () => onTap(b),
              );
            },
          ),
        ),
      ],
    );
  }
}
