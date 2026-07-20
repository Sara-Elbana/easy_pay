import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:easy_pay_app/core/routes/app_routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/beneficiary_cubit.dart';
import '../../domain/entities/beneficiary.dart';
import '../widgets/detail_avatar_header.dart';
import '../widgets/detail_fields_card.dart';

class BeneficiaryDetailScreen extends StatelessWidget {
  final Beneficiary beneficiary;

  const BeneficiaryDetailScreen({
    super.key,
    required this.beneficiary,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BeneficiaryCubit>();

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: DetailAvatarHeader(
        avatarUrl: beneficiary.avatarUrl,
        name: beneficiary.name,
        onBack: () => Navigator.pop(context),
        onEdit: () {
          cubit.initEditBeneficiary(beneficiary);
          final navigator = Navigator.of(context);
          navigator.pushNamed(
            AppRoutesName.addBeneficiaryScreen,
            arguments: cubit,
          ).then((_) {
            cubit.loadBeneficiaries();
            navigator.pop();
          });
        },
      ),
      body: Column(
        children: [
          SizedBox(height: context.scaleHeight(24)),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x0D000000),
                    offset: Offset(0, -2),
                    blurRadius: 3,
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.padHigh,
                    vertical: context.scaleHeight(24),
                  ),
                  child: DetailFieldsCard(
                    beneficiary: beneficiary,
                    onConfirm: () {
                      Navigator.pop(context, beneficiary);
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
