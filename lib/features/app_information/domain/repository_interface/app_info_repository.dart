import 'package:easy_pay_app/features/app_information/domain/entities/app_info_entity.dart';

abstract class AppInfoRepository {
  Future<AppInfoEntity> getAppInfo();
}
