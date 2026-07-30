import 'package:dio/dio.dart';
import 'package:easy_pay_app/core/constants/api_constants.dart';
import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/core/network/api_service.dart';
import 'package:easy_pay_app/features/auth/data/models/requests/reset_password_request.dart';
import 'package:easy_pay_app/features/auth/data/models/requests/send_otp_request.dart';
import 'package:easy_pay_app/features/auth/data/models/requests/sign_in_request.dart';
import 'package:easy_pay_app/features/auth/data/models/requests/sign_up_request.dart';
import 'package:easy_pay_app/features/auth/data/models/requests/verify_otp_request.dart';
import 'package:easy_pay_app/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<ApiResult<UserModel>> signIn(SignInRequest request);
  Future<ApiResult<UserModel>> signUp(SignUpRequest request);
  Future<ApiResult<bool>> sendOtp(SendOtpRequest request);
  Future<ApiResult<bool>> verifyOtp(VerifyOtpRequest request);
  Future<ApiResult<bool>> resetPassword(ResetPasswordRequest request);
  Future<ApiResult<bool>> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService apiService;

  AuthRemoteDataSourceImpl({required this.apiService});

  @override
  Future<ApiResult<UserModel>> signIn(SignInRequest request) async {
    try {
      final response = await apiService.post(
        ApiConstants.loginEndpoint,
        data: request.toJson(),
      );
      if (response.data == null) {
        return const ApiFailure(error: 'Invalid response format');
      }
      final model = UserModel.fromJson(response.data as Map<String, dynamic>);
      return ApiSuccess(data: model);
    } on DioException catch (e) {
      return ApiFailure(error: _extractErrorMessage(e));
    } catch (_) {
      return const ApiFailure(error: ApiConstants.unknownError);
    }
  }

  @override
  Future<ApiResult<UserModel>> signUp(SignUpRequest request) async {
    try {
      final response = await apiService.post(
        ApiConstants.registerEndpoint,
        data: request.toJson(),
      );
      if (response.data == null) {
        return const ApiFailure(error: 'Invalid response format');
      }
      final model = UserModel.fromJson(response.data as Map<String, dynamic>);
      return ApiSuccess(data: model);
    } on DioException catch (e) {
      return ApiFailure(error: _extractErrorMessage(e));
    } catch (_) {
      return const ApiFailure(error: ApiConstants.unknownError);
    }
  }

  @override
  Future<ApiResult<bool>> sendOtp(SendOtpRequest request) async {
    try {
      await apiService.post(
        ApiConstants.forgotPasswordSendEndpoint,
        data: request.toJson(),
      );
      return const ApiSuccess(data: true);
    } on DioException catch (e) {
      return ApiFailure(error: _extractErrorMessage(e));
    } catch (_) {
      return const ApiFailure(error: ApiConstants.unknownError);
    }
  }

  @override
  Future<ApiResult<bool>> verifyOtp(VerifyOtpRequest request) async {
    try {
      await apiService.post(
        ApiConstants.forgotPasswordVerifyEndpoint,
        data: request.toJson(),
      );
      return const ApiSuccess(data: true);
    } on DioException catch (e) {
      return ApiFailure(error: _extractErrorMessage(e));
    } catch (_) {
      return const ApiFailure(error: ApiConstants.unknownError);
    }
  }

  @override
  Future<ApiResult<bool>> resetPassword(ResetPasswordRequest request) async {
    try {
      await apiService.post(
        ApiConstants.forgotPasswordResetEndpoint,
        data: request.toJson(),
      );
      return const ApiSuccess(data: true);
    } on DioException catch (e) {
      return ApiFailure(error: _extractErrorMessage(e));
    } catch (_) {
      return const ApiFailure(error: ApiConstants.unknownError);
    }
  }

  @override
  Future<ApiResult<bool>> signOut() async {
    try {
      await apiService.post(ApiConstants.logoutEndpoint);
      return const ApiSuccess(data: true);
    } on DioException catch (e) {
      return ApiFailure(error: _extractErrorMessage(e));
    } catch (_) {
      return const ApiFailure(error: ApiConstants.unknownError);
    }
  }

  String _extractErrorMessage(DioException e) {
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
}
