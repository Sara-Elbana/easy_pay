import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:easy_pay_app/core/widgets/custom_app_bar.dart';
import 'package:easy_pay_app/core/widgets/custom_error_widget.dart';
import 'package:easy_pay_app/core/widgets/custom_loading_widget.dart';
import 'package:easy_pay_app/features/account_and_card/presentation/widgets/profile_header.dart';
import 'package:easy_pay_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:easy_pay_app/features/profile/presentation/cubit/profile_state.dart';
import 'package:easy_pay_app/features/profile/presentation/widgets/profile_expansion_tile.dart';
import 'package:easy_pay_app/features/profile/presentation/widgets/profile_info_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'profile'.tr(),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is BaseLoading) {
            return const CustomLoadingWidget();
          } else if (state is BaseError) {
            return CustomErrorWidget(message: (state as BaseError).message);
          } else if (state is BaseSuccess) {
            final profile = (state as BaseSuccess).data;
            return SingleChildScrollView(
              padding: EdgeInsets.all(context.scaleWidth(20)),
              child: Column(
                children: [
                  ProfileHeader(userName: profile.name),
                  SizedBox(height: context.scaleHeight(34)),
                  ProfileExpansionTile(
                    title: 'personal_information'.tr(),
                    icon: Icons.person_outline_rounded,
                    children: [
                      ProfileInfoRow(label: 'name'.tr(), value: profile.name),
                      ProfileInfoRow(label: 'phone'.tr(), value: profile.phone),
                    ],
                  ),
                  SizedBox(height: context.scaleHeight(16)),
                  ProfileExpansionTile(
                    title: 'account_details'.tr(),
                    icon: Icons.account_balance_wallet_outlined,
                    children: [
                      ProfileInfoRow(
                          label: 'account_number'.tr(), value: profile.accountNumber),
                      ProfileInfoRow(label: 'balance'.tr(), value: '\$${profile.balance}'),
                    ],
                  ),
                  SizedBox(height: context.scaleHeight(16)),
                  ProfileExpansionTile(
                    title: 'card_details'.tr(),
                    icon: Icons.credit_card_rounded,
                    children: [
                      ProfileInfoRow(
                          label: 'card_number'.tr(), value: profile.cardNumber),
                      ProfileInfoRow(label: 'card_holder'.tr(), value: profile.cardHolderName),
                      ProfileInfoRow(
                          label: 'card_type'.tr(), value: profile.cardType),
                      ProfileInfoRow(label: 'expiration'.tr(), value: profile.expirationDate),
                    ],
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}