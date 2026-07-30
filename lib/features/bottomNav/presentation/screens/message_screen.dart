import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/di/service_locator.dart';
import 'package:easy_pay_app/core/routes/app_routes_name.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/widgets/custom_app_bar.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:easy_pay_app/core/widgets/custom_error_widget.dart';
import 'package:easy_pay_app/core/widgets/custom_loading_widget.dart';
import 'package:easy_pay_app/features/message/presentation/cubit/notification_cubit.dart';
import 'package:easy_pay_app/features/message/presentation/cubit/notification_state.dart';
import 'package:easy_pay_app/features/message/presentation/widgets/message_card.dart';
import 'package:easy_pay_app/features/message/presentation/widgets/message_style_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<NotificationCubit>()..fetchNotifications(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: CustomAppBar(
          title: "message".tr(),
        ),
        body: Padding(
          padding: EdgeInsets.all(context.scaleWidth(24.0)),
          child: BlocBuilder<NotificationCubit, NotificationState>(
            builder: (context, state) {
              if (state is NotificationLoading) {
                return const CustomLoadingWidget();
              } else if (state is NotificationError) {
                return CustomErrorWidget(message: state.message);
              } else if (state is NotificationSuccess) {
                final notifications = state.notifications;

                if (notifications.isEmpty) {
                  return const Center(child: Text("No messages found"));
                }
                return ListView.separated(
                  itemCount: notifications.length,
                  separatorBuilder: (context, index) =>
                      SizedBox(height: context.scaleHeight(20)),
                  itemBuilder: (context, index) {
                    final notification = notifications[index];
                    final notificationDetails = MessageStyleHelper.getDetails(index);
                    return MessageCard(
                      iconAsset: notificationDetails['icon'],
                      iconBackgroundColor: notificationDetails['color'],
                      title: notification.senderName.isEmpty ? 'notification'.tr() : notification.senderName,
                      subtitle: notification.message,
                      date: notificationDetails['date'],
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutesName.chatScreen,
                          arguments: notification.id,
                        );
                      },
                    );
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

}