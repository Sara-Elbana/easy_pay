import 'package:easy_pay_app/core/constants/api_constants.dart';
import 'package:easy_pay_app/core/network/api_service.dart';
import 'package:easy_pay_app/features/profile/data/models/profile_model.dart';

class ProfileRemoteDataSource {
  final ApiService apiService;

  ProfileRemoteDataSource(this.apiService);


  Future<ProfileModel> getProfileData() async {
    final response = await apiService.get(ApiConstants.profileEndpoint);
    return ProfileModel.fromJson(response.data);
  }
}
