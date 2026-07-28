import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/constants/app_assets.dart';
import 'package:easy_pay_app/core/routes/app_routes_name.dart';
import 'package:easy_pay_app/core/widgets/header_widget.dart';
import 'package:easy_pay_app/features/bottomNav/presentation/widgets/notification_icon_button.dart';
import 'package:easy_pay_app/features/message/presentation/cubit/notification_cubit.dart';
import 'package:easy_pay_app/features/message/presentation/cubit/notification_state.dart';
import 'package:easy_pay_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:easy_pay_app/features/profile/presentation/cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, profileState) {
        final userName = profileState is ProfileSuccess
            ? profileState.profile.name
            : "User";

        return BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, notificationState) {
            int unreadCount = 0;
            if (notificationState is NotificationSuccess) {
              unreadCount = notificationState.notifications
                  .where((item) => item.isRead == 0)
                  .length;
            }

            return HeaderWidget(
              title: "hi_user".tr(args: [userName]),
              leading: const CircleAvatar(
                radius: 22,
                backgroundImage: AssetImage(AppAssets.avatarImage),
              ),
              trailing: NotificationIconButton(
                unreadCount: unreadCount,
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutesName.messageScreen);
                },
              ),
            );
          },
        );
      },
    );
  }
}