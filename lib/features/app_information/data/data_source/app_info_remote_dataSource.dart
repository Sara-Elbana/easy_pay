import 'package:dio/dio.dart';
import 'package:easy_pay_app/core/constants/api_constants.dart';
import 'package:easy_pay_app/core/di/service_locator.dart';
import 'package:easy_pay_app/features/app_information/data/model/app_info_model.dart';

class AppInfoRemoteDataSource {
  final Dio dio;

  AppInfoRemoteDataSource(): dio = getIt<Dio>();

  Future<AppInfoModel> getAppInfo() async {
    final response = await dio.get(ApiConstants.appInfoEndpoint);
    return AppInfoModel.fromJson(response.data);
  }
}
