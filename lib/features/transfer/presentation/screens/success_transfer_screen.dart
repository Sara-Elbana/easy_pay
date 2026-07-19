import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/routes/app_routes_name.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/widgets/custom_app_bar.dart';
import 'package:easy_pay_app/core/widgets/custom_button.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/transfer_cubit.dart';
import '../cubit/transfer_state.dart';

class SuccessTransferScreen extends StatelessWidget {
  const SuccessTransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = ModalRoute.of(context)!.settings.arguments as TransferCubit;

    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: CustomAppBar(
          title: 'confirm_label'.tr(),
          leadingIcon: Icons.arrow_back_ios_new,
          leadingIconSize: 20,
          backgroundColor: theme.scaffoldBackgroundColor,
        ),
        body: BlocBuilder<TransferCubit, TransferState>(
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: context.padHigh, vertical: context.scaleHeight(20.0)),
                child: Column(
                  children: [
                    const Spacer(),
                    Image.asset(
                      'assets/images/success_illustration.png',
                      height: context.scaleHeight(220),
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: context.scaleHeight(40)),
                    Text(
                      'transfer_successful'.tr(),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: context.scaleHeight(16)),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 15,
                          color: AppColors.textDark,
                          height: 1.4,
                        ),
                        children: [
                          const TextSpan(
                              text: 'You have successfully transferred '),
                          TextSpan(
                            text: '\$${state.amount}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.error,
                            ),
                          ),
                          const TextSpan(text: ' to '),
                          TextSpan(
                            text: state.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                          const TextSpan(text: '!'),
                        ],
                      ),
                    ),
                    const Spacer(flex: 2),
                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        text: 'confirm_label'.tr(),
                        onPressed: () {
                          cubit.reset();
                          Navigator.pushNamed(
                              context, AppRoutesName.mainScreen);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
