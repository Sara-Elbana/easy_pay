import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/widgets/custom_app_bar.dart';
import 'package:easy_pay_app/core/widgets/custom_button.dart';
import 'package:easy_pay_app/core/utils/card_number_formatter.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:easy_pay_app/core/widgets/custom_error_widget.dart';
import 'package:easy_pay_app/core/widgets/custom_loading_widget.dart';
import 'package:easy_pay_app/core/widgets/custom_text_field.dart';
import 'package:easy_pay_app/features/account_and_card/presentation/cubit/card_cubit.dart';
import 'package:easy_pay_app/features/account_and_card/presentation/cubit/card_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final _formKey = GlobalKey<FormState>();
  final _holderNameController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expirationDateController = TextEditingController();
  final _cardTypeController = TextEditingController();

  @override
  void dispose() {
    _holderNameController.dispose();
    _cardNumberController.dispose();
    _expirationDateController.dispose();
    _cardTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'add_card'.tr(),
      ),
      body: Padding(
        padding: EdgeInsets.all(context.scaleWidth(24)),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextField(
                hintText: 'Card Holder Name',
                controller: _holderNameController,
                validator: (value) =>
                value!.isEmpty ? 'Please enter card holder name' : null,
              ),
              SizedBox(height: context.scaleHeight(16)),
              CustomTextField(
                hintText: 'Card Number',
                controller: _cardNumberController,
                keyboardType: TextInputType.number,
                inputFormatters: [CardNumberFormatter()],
                validator: (value) {
                  final clean = value?.replaceAll(RegExp(r'\D'), '') ?? '';
                  return clean.length < 16 ? 'Enter a valid card number' : null;
                },
              ),
              SizedBox(height: context.scaleHeight(16)),
              CustomTextField(
                hintText: 'Expiration Date (MM/YY)',
                controller: _expirationDateController,
                keyboardType: TextInputType.datetime,
                validator: (value) =>
                value!.isEmpty ? 'Enter expiration date' : null,
              ),
              SizedBox(height: context.scaleHeight(16)),
              CustomTextField(
                hintText: 'Card Type (Visa / Mastercard)',
                controller: _cardTypeController,
              ),
              SizedBox(height: context.scaleHeight(32)),
              BlocConsumer<CardCubit, CardState>(
                listener: (context, state) {
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      if (state is BaseError) ...[
                        CustomErrorWidget(message: (state as BaseError).message),
                        SizedBox(height: context.scaleHeight(16)),
                      ],
                      state is BaseLoading
                          ? const Center(child: CustomLoadingWidget())
                          : CustomButton(
                        text: 'save_card'.tr(),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final cardData = {
                              "card_holder_name": _holderNameController.text,
                              "card_number": _cardNumberController.text,
                              "expiration_date": _expirationDateController.text,
                              "card_type": _cardTypeController.text,
                            };
                            final success = await context
                                .read<CardCubit>()
                                .addNewCard(cardData);
                            if (success && context.mounted) {
                              Navigator.pop(context);
                            }
                          }
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}