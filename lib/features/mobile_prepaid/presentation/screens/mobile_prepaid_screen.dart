import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/routes/app_routes_name.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/theme/app_text_styles.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:easy_pay_app/core/utils/validators.dart';
import 'package:easy_pay_app/core/widgets/account_dropdown.dart';
import 'package:easy_pay_app/core/widgets/amount_selector_grid.dart';
import 'package:easy_pay_app/core/widgets/choose_beneficiary_section.dart';
import 'package:easy_pay_app/core/widgets/custom_app_bar.dart';
import 'package:easy_pay_app/core/widgets/custom_button.dart';
import 'package:easy_pay_app/core/widgets/custom_text_field.dart';
import 'package:easy_pay_app/features/beneficiary/domain/entities/beneficiary.dart';
import 'package:easy_pay_app/features/transfer/domain/entities/transfer_card.dart';
import 'package:flutter/material.dart';

class MobilePrepaidScreen extends StatefulWidget {
  const MobilePrepaidScreen({super.key});

  @override
  State<MobilePrepaidScreen> createState() => _MobilePrepaidScreenState();
}

class _MobilePrepaidScreenState extends State<MobilePrepaidScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _customAmountController = TextEditingController();

  TransferCard? _selectedCard;
  Beneficiary? _selectedBeneficiary;
  bool _isManualBeneficiary = false;
  int? _selectedAmount;
  bool _isOtherSelected = false;

  final List<TransferCard> _cards = const [
    TransferCard(
      id: '1',
      cardNumber: 'VISA **** **** **** 1234',
      balance: 'Available balance : 10,000\$',
    ),
    TransferCard(
      id: '2',
      cardNumber: 'Mastercard **** **** **** 5678',
      balance: 'Available balance : 5,500\$',
    ),
  ];

  final List<Beneficiary> _beneficiaries = const [
    Beneficiary(
      id: '1',
      name: 'Emma',
      cardNumber: '+8564757899',
      type: 0,
      avatarUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150',
    ),
    Beneficiary(
      id: '2',
      name: 'Justin',
      cardNumber: '+8564757800',
      type: 0,
      avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150',
    ),
  ];

  @override
  void dispose() {
    _phoneController.dispose();
    _customAmountController.dispose();
    super.dispose();
  }

  bool get _isFormValid {
    final hasCard = _selectedCard != null;
    final hasPhone = _phoneController.text.trim().isNotEmpty || _selectedBeneficiary != null;
    final hasAmount = _selectedAmount != null || (_isOtherSelected && _customAmountController.text.trim().isNotEmpty);
    return hasCard && hasPhone && hasAmount;
  }

  void _onConfirm() {
    if (_formKey.currentState?.validate() ?? false) {
      final amountStr = _selectedAmount != null
          ? '\$$_selectedAmount'
          : '\$${_customAmountController.text}';
      Navigator.pushNamed(
        context,
        AppRoutesName.mobilePrepaidConfirmScreen,
        arguments: {
          'fromCard': _selectedCard?.cardNumber ?? '**** **** 6789',
          'toPhone': _phoneController.text.isNotEmpty
              ? _phoneController.text
              : (_selectedBeneficiary?.cardNumber ?? '+8564757899'),
          'amount': amountStr,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: 'Mobile prepaid'.tr(),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.scaleWidth(24),
                    vertical: context.scaleHeight(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. Account Dropdown
                      AccountDropdown(
                        cards: _cards,
                        selectedCard: _selectedCard,
                        onChanged: (card) {
                          setState(() {
                            _selectedCard = card;
                          });
                        },
                      ),
                      SizedBox(height: context.scaleHeight(24)),

                      // 2. Choose Beneficiary Section
                      ChooseBeneficiarySection(
                        beneficiaries: _beneficiaries,
                        selectedBeneficiary: _selectedBeneficiary,
                        isManualBeneficiary: _isManualBeneficiary,
                        isEnabled: true,
                        onSelectManual: () {
                          setState(() {
                            _isManualBeneficiary = true;
                            _selectedBeneficiary = null;
                            _phoneController.clear();
                          });
                        },
                        onSelectBeneficiary: (b) {
                          setState(() {
                            _selectedBeneficiary = b;
                            _isManualBeneficiary = false;
                            _phoneController.text = b.cardNumber;
                          });
                        },
                        onFindBeneficiary: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutesName.beneficiaryDirectoryScreen,
                          );
                        },
                      ),
                      SizedBox(height: context.scaleHeight(24)),

                      // 3. Custom Text Field with phone validator
                      Text(
                        'Phone number'.tr(),
                        style: AppTextStyles.bodyMediumSemiBold.copyWith(
                          color: AppColors.textLight,
                        ),
                      ),
                      SizedBox(height: context.scaleHeight(8)),
                      CustomTextField(
                        hintText: 'Phone number'.tr(),
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        validator: Validators.validatePhone,
                        onChanged: (val) {
                          setState(() {});
                        },
                      ),
                      SizedBox(height: context.scaleHeight(24)),

                      // 4. Amount Selector Grid
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Choose amount'.tr(),
                            style: AppTextStyles.bodyMediumSemiBold.copyWith(
                              color: AppColors.textLight,
                            ),
                          ),
                          SizedBox(height: context.scaleHeight(12)),
                          if (_isOtherSelected)
                            CustomTextField(
                              hintText: 'amount_label'.tr(),
                              controller: _customAmountController,
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              onChanged: (val) {
                                setState(() {});
                              },
                            )
                          else
                            AmountSelectorGrid(
                              selectedAmount: _selectedAmount,
                              isOtherSelected: _isOtherSelected,
                              isEnabled: true,
                              onAmountSelected: (amt) {
                                setState(() {
                                  _selectedAmount = amt;
                                  _isOtherSelected = false;
                                  _customAmountController.clear();
                                });
                              },
                              onOtherSelected: () {
                                setState(() {
                                  _isOtherSelected = true;
                                  _selectedAmount = null;
                                });
                              },
                            ),
                        ],
                      ),
                      SizedBox(height: context.scaleHeight(24)),
                    ],
                  ),
                ),
              ),

              // 5. Custom Button
              Padding(
                padding: EdgeInsets.all(context.scaleWidth(24)),
                child: CustomButton(
                  text: 'Confirm'.tr(),
                  isEnabled: _isFormValid,
                  onPressed: _isFormValid ? _onConfirm : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
