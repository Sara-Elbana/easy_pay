import 'package:easy_pay_app/features/app_information/domain/entities/app_info_entity.dart';

abstract class AppInfoState {}

class AppInfoInitial extends AppInfoState {}

class AppInfoLoading extends AppInfoState {}

class AppInfoSuccess extends AppInfoState {
  final AppInfoEntity appInfo;
  AppInfoSuccess(this.appInfo);
}

class AppInfoError extends AppInfoState {
  final String message;
  AppInfoError(this.message);
}
