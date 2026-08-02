import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/theme/app_text_styles.dart';
import 'package:easy_pay_app/core/widgets/custom_app_bar.dart';
import 'package:easy_pay_app/features/exchange_rate/presentation/widgets/exchange_rate_header.dart';
import 'package:easy_pay_app/features/interest_rate/presentation/cubit/interest_cubit.dart';
import 'package:easy_pay_app/features/interest_rate/presentation/cubit/interest_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InterestRateScreen extends StatelessWidget {
  const InterestRateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "interest_rate".tr()),
      body: BlocBuilder<InterestCubit, InterestState>(
        builder: (context, state) {
          if (state is BaseLoading || state is BaseInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is BaseError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  (state as BaseError).message,
                  style: AppTextStyles.bodyMediumError,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          if (state is BaseSuccess) {
            final data = (state as BaseSuccess).data;
            if (data.isEmpty) {
              return Center(
                child: Text('no_data'.tr()),
              );
            }

            return Column(
              children: [
                const ExchangeRateHeader(
                  title1: "interest_kind",
                  title2: "deposit",
                  title3: "rate",
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: data.length,
                    separatorBuilder: (_, __) =>
                        const Divider(color: AppColors.thinDivider),
                    itemBuilder: (context, index) {
                      final item = data[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Text(
                                item.kind,
                                style: AppTextStyles.bodyMedium,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                item.deposit,
                                textAlign: TextAlign.right,
                                style: AppTextStyles.bodyMediumDark,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                item.rate,
                                textAlign: TextAlign.right,
                                style: AppTextStyles.bodyMediumPrimary,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
