import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/withdraw_cubit.dart';
import '../cubit/withdraw_state.dart';

class WithdrawPhoneField extends StatefulWidget {
  const WithdrawPhoneField({super.key});

  @override
  State<WithdrawPhoneField> createState() => _WithdrawPhoneFieldState();
}

class _WithdrawPhoneFieldState extends State<WithdrawPhoneField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final initialVal = context.read<WithdrawCubit>().state.phoneNumber;
    _controller = TextEditingController(text: initialVal);
    _controller.addListener(_onChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onChanged() {
    context.read<WithdrawCubit>().updatePhone(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WithdrawCubit, WithdrawState>(
      listenWhen: (previous, current) => previous.phoneNumber != current.phoneNumber,
      listener: (context, state) {
        if (state.phoneNumber != _controller.text) {
          _controller.value = TextEditingValue(
            text: state.phoneNumber,
            selection: TextSelection.collapsed(offset: state.phoneNumber.length),
          );
        }
      },
      buildWhen: (previous, current) => previous.isPhoneEnabled != current.isPhoneEnabled,
      builder: (context, state) {
        return CustomTextField(
          hintText: 'phone_number'.tr(),
          controller: _controller,
          enabled: state.isPhoneEnabled,
          keyboardType: TextInputType.phone,
        );
      },
    );
  }
}
