import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/widgets/custom_button.dart';
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: theme.iconTheme.color ?? AppColors.textDark,
              size: 20,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'confirm_label'.tr(),
            style: TextStyle(
              color: theme.textTheme.titleLarge?.color ?? AppColors.textDark,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: false,
        ),
        body: BlocBuilder<TransferCubit, TransferState>(
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                child: Column(
                  children: [
                    const Spacer(),
                    Image.asset(
                      'assets/images/success_illustration.png',
                      height: 220,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'transfer_successful'.tr(),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 15,
                          color: AppColors.textDark,
                          height: 1.4,
                        ),
                        children: [
                          const TextSpan(text: 'You have successfully transferred '),
                          TextSpan(
                            text: '\$${state.amount}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.error, // Pink/red accent for amount
                            ),
                          ),
                          const TextSpan(text: ' to '),
                          TextSpan(
                            text: state.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary, // Dark blue accent for name
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
                          // Pop back all the way to Home Screen
                          Navigator.popUntil(context, (route) => route.isFirst);
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
