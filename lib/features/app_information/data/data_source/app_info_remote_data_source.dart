import 'package:easy_pay_app/core/constants/api_constants.dart';
import 'package:easy_pay_app/features/app_information/data/model/app_info_model.dart';
import 'package:easy_pay_app/core/network/api_service.dart';

class AppInfoRemoteDataSource {
  final ApiService apiService;

  AppInfoRemoteDataSource(this.apiService);

  Future<AppInfoModel> getAppInfo() async {
    final response = await apiService.get(ApiConstants.appInfoEndpoint);
    return AppInfoModel.fromJson(response.data);
  }
}