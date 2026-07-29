import 'package:easy_pay_app/core/di/service_locator.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/features/bottomNav/presentation/widgets/credit_card_stack.dart';
import 'package:easy_pay_app/features/bottomNav/presentation/widgets/home_menu_grid.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:easy_pay_app/features/bottomNav/presentation/widgets/home_header.dart';
import 'package:easy_pay_app/features/message/presentation/cubit/notification_cubit.dart';
import 'package:easy_pay_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<NotificationCubit>()..fetchNotifications(),
        ),
        BlocProvider(
          create: (context) => getIt<ProfileCubit>()..fetchProfile(),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Column(
          children: [
            const HomeHeader(),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(context.scaleWidth(30)),
                    topRight: Radius.circular(context.scaleWidth(30)),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.padMedium,
                    vertical: context.scaleHeight(4),
                  ),
                  child: const Column(
                    children: [
                      CreditCardStack(),
                      HomeMenuGrid(),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}