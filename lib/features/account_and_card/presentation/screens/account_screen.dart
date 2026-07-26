import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/core.dart';
import 'package:easy_pay_app/core/widgets/custom_app_bar.dart';
import 'package:easy_pay_app/features/account_and_card/presentation/cubit/account_cubit.dart';
import 'package:easy_pay_app/features/account_and_card/presentation/cubit/card_cubit.dart';
import 'package:easy_pay_app/features/account_and_card/presentation/widgets/account_content_body.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AccountCubit>()..loadAccounts()),
        BlocProvider(create: (context) => getIt<CardCubit>()..loadCards()),
      ],
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: CustomAppBar(title: "account_and_card".tr()),
        body: const AccountContentBody(),
      ),
    );
  }
}