import 'package:easy_pay_app/core/core.dart';
import 'package:easy_pay_app/core/cubit/base_state.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:easy_pay_app/core/widgets/card_container.dart';
import 'package:easy_pay_app/core/widgets/custom_app_bar.dart';
import 'package:easy_pay_app/core/widgets/custom_error_widget.dart';
import 'package:easy_pay_app/core/widgets/custom_loading_widget.dart';
import 'package:easy_pay_app/features/save_online/data/model/savings_account_model.dart';
import 'package:easy_pay_app/features/save_online/presentation/cubit/savings_cubit.dart';
import 'package:easy_pay_app/features/save_online/presentation/widgets/management_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManagementScreen extends StatelessWidget {
  const ManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: const CustomAppBar(
          title: "Management",
        ),
        body:
            BlocBuilder<ManagementCubit, BaseState<List<SavingsAccountModel>>>(
          builder: (context, state) {
            if (state is BaseLoading) {
              return const CustomLoadingWidget();
            }

            if (state is BaseError) {
              return CustomErrorWidget(message: (state as BaseError).message);
            }

            if (state is BaseSuccess<List<SavingsAccountModel>>) {
              final items = state.data;

              if (items.isEmpty) {
                return const Center(child: Text("No data available"));
              }

              return ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: context.scaleWidth(24),
                  vertical: context.scaleHeight(16),
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return CardContainer(
                      child: Column(
                    children: [
                      ManagementItemCard(
                        label: "Account",
                        value: item.accountNumber,
                        isTitle: true,
                      ),
                      ManagementItemCard(label: "From", value: item.startDate),
                      SizedBox(height: context.scaleHeight(8)),
                      ManagementItemCard(label: "To", value: item.endDate),
                      SizedBox(height: context.scaleHeight(8)),
                      ManagementItemCard(
                          label: "Time deposit", value: item.amount),
                      SizedBox(height: context.scaleHeight(8)),
                      ManagementItemCard(
                          label: "Interest rate",
                          value: '${item.interestRate}%'),
                    ],
                  ));
                },
              );
            }
            return const SizedBox.shrink();
          },
        ));
  }
}
