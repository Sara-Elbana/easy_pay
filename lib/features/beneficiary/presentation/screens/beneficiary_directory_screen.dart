import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:easy_pay_app/core/widgets/custom_app_bar.dart';
import 'package:easy_pay_app/core/routes/app_routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/beneficiary_cubit.dart';
import '../cubit/beneficiary_state.dart';
import '../widgets/beneficiary_search_field.dart';
import '../widgets/beneficiary_section_card.dart';

class BeneficiaryDirectoryScreen extends StatelessWidget {
  const BeneficiaryDirectoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BeneficiaryCubit>();
    final searchController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: 'beneficiary'.tr(),
      ),
      body: BlocBuilder<BeneficiaryCubit, BeneficiaryState>(
        builder: (context, state) {
          if (state.isLoading && state.beneficiaries.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            );
          }

          final query = state.bankSearchQuery;
          final allBeneficiaries = state.beneficiaries;
          final filteredList = query.isEmpty
              ? allBeneficiaries
              : allBeneficiaries
                  .where((b) => b.name.toLowerCase().contains(query.toLowerCase()) ||
                      b.cardNumber.contains(query))
                  .toList();

          final cardList = filteredList.where((b) => b.type == 0).toList();
          final sameBankList = filteredList.where((b) => b.type == 1).toList();
          final otherBankList = filteredList.where((b) => b.type == 2).toList();

          return SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.padHigh,
                        vertical: context.scaleHeight(12),
                      ),
                      child: BeneficiarySearchField(
                        controller: searchController,
                        onChanged: cubit.updateBankSearch,
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.padHigh,
                          vertical: context.scaleHeight(12),
                        ),
                        physics: const BouncingScrollPhysics(),
                        children: [
                          BeneficiarySectionCard(
                            title: 'transfer_via_card_number'.tr().replaceAll('\n', ' '),
                            items: cardList,
                            onTap: (b) {
                              final navigator = Navigator.of(context);
                              navigator.pushNamed(
                                AppRoutesName.beneficiaryDetailScreen,
                                arguments: {
                                  'cubit': cubit,
                                  'beneficiary': b,
                                },
                              ).then((result) {
                                if (result != null) {
                                  navigator.pop(result);
                                }
                              });
                            },
                          ),
                          SizedBox(height: context.scaleHeight(24)),
                          BeneficiarySectionCard(
                            title: 'transfer_to_same_bank'.tr().replaceAll('\n', ' '),
                            items: sameBankList,
                            onTap: (b) {
                              final navigator = Navigator.of(context);
                              navigator.pushNamed(
                                AppRoutesName.beneficiaryDetailScreen,
                                arguments: {
                                  'cubit': cubit,
                                  'beneficiary': b,
                                },
                              ).then((result) {
                                if (result != null) {
                                  navigator.pop(result);
                                }
                              });
                            },
                          ),
                          SizedBox(height: context.scaleHeight(24)),
                          BeneficiarySectionCard(
                            title: 'transfer_to_another_bank'.tr().replaceAll('\n', ' '),
                            items: otherBankList,
                            onTap: (b) {
                              final navigator = Navigator.of(context);
                              navigator.pushNamed(
                                AppRoutesName.beneficiaryDetailScreen,
                                arguments: {
                                  'cubit': cubit,
                                  'beneficiary': b,
                                },
                              ).then((result) {
                                if (result != null) {
                                  navigator.pop(result);
                                }
                              });
                            },
                          ),
                          SizedBox(height: context.scaleHeight(100)),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: context.scaleHeight(24),
                  right: context.scaleWidth(24),
                  child: FloatingActionButton(
                    backgroundColor: AppColors.primary,
                    elevation: 4,
                    shape: const CircleBorder(),
                    onPressed: () {
                      cubit.resetForm();
                      final navigator = Navigator.of(context);
                      navigator.pushNamed(
                        AppRoutesName.addBeneficiaryScreen,
                        arguments: cubit,
                      ).then((_) => cubit.loadBeneficiaries());
                    },
                    child: const Icon(Icons.add, color: Colors.white, size: 28),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
