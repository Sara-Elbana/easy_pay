import 'package:dio/dio.dart';
import 'package:easy_pay_app/core/constants/api_constants.dart';
import 'package:easy_pay_app/core/di/service_locator.dart';
import 'package:easy_pay_app/features/profile/data/models/profile_model.dart';

class ProfileRemoteDataSource {
  final Dio dio;

  ProfileRemoteDataSource(): dio = getIt<Dio>();

  Future<ProfileModel> getProfileData() async {
    final response = await dio.get(ApiConstants.profileEndpoint);
    return ProfileModel.fromJson(response.data);
  }
}
