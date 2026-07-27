import 'package:dio/dio.dart';
import 'package:easy_pay_app/core/constants/api_constants.dart';
import 'package:easy_pay_app/core/network/api_service.dart';
import 'package:easy_pay_app/features/auth/data/models/requests/reset_password_request.dart';
import 'package:easy_pay_app/features/auth/data/models/requests/send_otp_request.dart';
import 'package:easy_pay_app/features/auth/data/models/requests/sign_in_request.dart';
import 'package:easy_pay_app/features/auth/data/models/requests/sign_up_request.dart';
import 'package:easy_pay_app/features/auth/data/models/requests/verify_otp_request.dart';
import 'package:easy_pay_app/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signIn(SignInRequest request);
  Future<UserModel> signUp(SignUpRequest request);
  Future<void> sendOtp(SendOtpRequest request);
  Future<void> verifyOtp(VerifyOtpRequest request);
  Future<void> resetPassword(ResetPasswordRequest request);
  Future<void> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService apiService;

  AuthRemoteDataSourceImpl({required this.apiService});

  @override
  Future<UserModel> signIn(SignInRequest request) async {
    try {
      final response = await apiService.post(
        ApiConstants.loginEndpoint,
        data: request.toJson(),
      );
      return UserModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw Exception(_extractErrorMessage(e));
    }
  }

  @override
  Future<UserModel> signUp(SignUpRequest request) async {
    try {
      final response = await apiService.post(
        ApiConstants.registerEndpoint,
        data: request.toJson(),
      );
      return UserModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw Exception(_extractErrorMessage(e));
    }
  }

  @override
  Future<void> sendOtp(SendOtpRequest request) async {
    try {
      await apiService.post(
        ApiConstants.forgotPasswordSendEndpoint,
        data: request.toJson(),
      );
    } catch (e) {
      throw Exception(_extractErrorMessage(e));
    }
  }

  @override
  Future<void> verifyOtp(VerifyOtpRequest request) async {
    try {
      await apiService.post(
        ApiConstants.forgotPasswordVerifyEndpoint,
        data: request.toJson(),
      );
    } catch (e) {
      throw Exception(_extractErrorMessage(e));
    }
  }

  @override
  Future<void> resetPassword(ResetPasswordRequest request) async {
    try {
      await apiService.post(
        ApiConstants.forgotPasswordResetEndpoint,
        data: request.toJson(),
      );
    } catch (e) {
      throw Exception(_extractErrorMessage(e));
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await apiService.post(ApiConstants.logoutEndpoint);
    } catch (e) {
      throw Exception(_extractErrorMessage(e));
    }
  }

  String _extractErrorMessage(dynamic e) {
    if (e is DioException) {
      if (e.response?.data != null && e.response?.data is Map) {
        final data = e.response!.data as Map<String, dynamic>;
        if (data.containsKey('message') && data['message'] != null) {
          return data['message'].toString();
        }
        if (data.containsKey('error') && data['error'] != null) {
          return data['error'].toString();
        }
      }
      return e.message ?? ApiConstants.unknownError;
    }
    return e.toString();
  }
}
