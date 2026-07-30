import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/constants/app_assets.dart';
import 'package:easy_pay_app/core/cubit/base_state.dart';
import 'package:easy_pay_app/core/routes/app_routes_name.dart';
import 'package:easy_pay_app/core/widgets/account_dropdown.dart';
import 'package:easy_pay_app/core/widgets/custom_button.dart';
import 'package:easy_pay_app/core/widgets/custom_error_widget.dart';
import 'package:easy_pay_app/core/widgets/custom_loading_widget.dart';
import 'package:easy_pay_app/core/widgets/custom_text_field.dart';
import 'package:easy_pay_app/features/save_online/presentation/cubit/savings_cubit.dart';
import 'package:easy_pay_app/features/save_online/presentation/widgets/time_deposit_dialog.dart';
import 'package:easy_pay_app/features/transfer/domain/entities/transfer_card.dart';
import 'package:flutter/material.dart';
import 'package:easy_pay_app/core/core.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:easy_pay_app/core/widgets/card_container.dart';
import 'package:easy_pay_app/core/widgets/custom_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _formKey = GlobalKey<FormState>();
  TransferCard? selectedAccountOrCard;

  // تأكدي من إعطاء كل عنصر ID فريد وصحيح للسيرفر
  final List<TransferCard> dummyCards = [
    const TransferCard(
      id: '13',
      cardNumber: 'Account 1900 8988 5456',
      balance: 'Available balance: 10000\$',
    ),
    const TransferCard(
      id: '14',
      cardNumber: 'Card **** **** **** 4321',
      balance: 'Available balance: 5000\$',
    ),
  ];

  final TextEditingController timeDepositController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  String? selectedTimeDeposit;
  int? selectedTermMonths;
  bool _isFormValid = false;

  void _checkFormFilled() {
    final amountText = amountController.text.trim();
    final amountValue = double.tryParse(amountText) ?? 0;

    final isValid = selectedAccountOrCard != null &&
        timeDepositController.text.trim().isNotEmpty &&
        amountText.isNotEmpty &&
        amountValue >= 1000;

    if (_isFormValid != isValid) {
      setState(() {
        _isFormValid = isValid;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    amountController.addListener(_checkFormFilled);
    timeDepositController.addListener(_checkFormFilled);
  }

  @override
  void dispose() {
    amountController.dispose();
    timeDepositController.dispose();
    super.dispose();
  }

  void _showTimeDepositDialog() {
    final List<TimeDepositOption> depositOptions = [
      const TimeDepositOption(duration: '3 months', months: 3, rate: '4%'),
      const TimeDepositOption(duration: '6 months', months: 6, rate: '4.5%'),
      const TimeDepositOption(duration: '12 months', months: 12, rate: '5%'),
      const TimeDepositOption(duration: '16 months', months: 16, rate: '5.5%'),
      const TimeDepositOption(duration: '24 months', months: 24, rate: '6%'),
    ];

    TimeDepositDialog.show(
      context: context,
      options: depositOptions,
      selectedDuration: selectedTimeDeposit,
      onSelected: (option) {
        setState(() {
          selectedTimeDeposit = option.duration;
          selectedTermMonths = option.months;
          timeDepositController.text = option.duration;
          _checkFormFilled();
        });
      },
    );
  }

  void _submitSavingRequest() {
    if (_formKey.currentState != null &&
        _formKey.currentState!.validate() &&
        selectedAccountOrCard != null) {
      context.read<ManagementCubit>().createSaving(
        bankAccountId: int.parse(selectedAccountOrCard!.id),
        amount: double.parse(amountController.text.trim()),
        termMonths: selectedTermMonths ?? 12,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(title: "Add"),
      body: BlocConsumer<ManagementCubit, BaseState>(
        listener: (context, state) {
          if (state is BaseSuccess) {
            Navigator.pushNamed(context, AppRoutesName.saveOnlineSuccessfully);
          }
        },
        builder: (context, state) {
          if (state is BaseLoading) {
            return const Center(
              child: CustomLoadingWidget(),
            );
          }

          if (state is BaseError) {
            return Center(
              child: CustomErrorWidget(
                message: state.message,
                onRetry:  _submitSavingRequest,
              ),
            );
          }

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: context.scaleWidth(24),
              vertical: context.scaleHeight(16),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset(AppAssets.addVerifyImage),
                  CardContainer(
                    child: Column(
                      children: [
                        AccountDropdown(
                          cards: dummyCards,
                          selectedCard: selectedAccountOrCard,
                          onChanged: (card) {
                            setState(() {
                              selectedAccountOrCard = card;
                              _checkFormFilled();
                            });
                          },
                        ),
                        SizedBox(height: context.scaleHeight(16)),
                        GestureDetector(
                          onTap: _showTimeDepositDialog,
                          child: AbsorbPointer(
                            child: CustomTextField(
                              hintText: "Choose time deposit",
                              controller: timeDepositController,
                              readOnly: true,
                            ),
                          ),
                        ),
                        if (selectedTimeDeposit != null) ...[
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Interest rate 5%/ ${timeDepositController.text}",
                              style: const TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                        SizedBox(height: context.scaleHeight(16)),
                        CustomTextField(
                          hintText: "Amount (At least \$1000)",
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter amount';
                            }
                            final amount = double.tryParse(value) ?? 0;
                            if (amount < 1000) {
                              return 'Amount must be at least \$1000';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: context.scaleHeight(24)),
                        CustomButton(
                          text: 'verify'.tr(),
                          isEnabled: _isFormValid,
                          onPressed: _submitSavingRequest,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}