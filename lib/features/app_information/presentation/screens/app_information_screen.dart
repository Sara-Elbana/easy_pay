import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/core.dart';
import 'package:easy_pay_app/core/widgets/custom_app_bar.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:easy_pay_app/features/app_information/presentation/cubit/app_info_cubit.dart';
import 'package:easy_pay_app/features/app_information/presentation/cubit/app_info_state.dart';
import 'package:easy_pay_app/features/setting/presentation/widgets/setting_row_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppInformationScreen extends StatelessWidget {
  const AppInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AppInfoCubit>()..fetchAppInfo(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: CustomAppBar(
          title: "app_information".tr(),
        ),
        body: BlocBuilder<AppInfoCubit, AppInfoState>(
          builder: (context, state) {
            if (state is AppInfoLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              );
            } else if (state is AppInfoSuccess) {
              final info = state.appInfo;
              return Padding(
                padding: EdgeInsets.all(context.scaleWidth(24.0)),
                child: Column(
                  children: [
                    Text(
                      info.appName,
                      style: AppTextStyles.titleLarge.copyWith(
                        fontSize: context.scaleWidth(
                            AppTextStyles.titleLarge.fontSize ?? 22),
                      ),
                    ),
                    SizedBox(
                      height: context.scaleHeight(28),
                    ),
                    SettingRowItem(
                      title: "date_of_manufacture".tr(),
                      showArrow: false,
                      trailing: Text(
                        info.dateOfManufacture,
                        style: AppTextStyles.bodyMediumSemiBold.copyWith(
                            fontSize: context.scaleWidth(
                                AppTextStyles.bodyMediumSemiBold.fontSize ??
                                    14),
                            color: AppColors.primary),
                      ),
                    ),
                    SettingRowItem(
                      title: "version".tr(),
                      showArrow: false,
                      trailing: Text(
                        info.version,
                        style: AppTextStyles.bodyMediumSemiBold.copyWith(
                            fontSize: context.scaleWidth(
                                AppTextStyles.bodyMediumSemiBold.fontSize ??
                                    14),
                            color: AppColors.primary),
                      ),
                    ),
                    SettingRowItem(
                      title: "language".tr(),
                      showArrow: false,
                      trailing: Text(
                        info.language,
                        style: AppTextStyles.bodyMediumSemiBold.copyWith(
                            fontSize: context.scaleWidth(
                                AppTextStyles.bodyMediumSemiBold.fontSize ??
                                    14),
                            color: AppColors.primary),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is AppInfoError) {
              return Center(
                child: Text(
                  state.message,
                  style: AppTextStyles.bodyMediumSemiBold.copyWith(
                    color: Colors.red,
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
