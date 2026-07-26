import 'package:dio/dio.dart';
import 'package:easy_pay_app/core/constants/api_constants.dart';
import 'package:easy_pay_app/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signIn(String phoneNumber, String password);
  Future<UserModel> signUp(String name, String phoneNumber, String password);
  Future<void> sendOtp(String phoneNumber);
  Future<void> verifyOtp(String phoneNumber, String code);
  Future<void> resetPassword(String phoneNumber, String code, String newPassword);
  Future<void> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<UserModel> signIn(String phoneNumber, String password) async {
    try {
      final response = await dio.post(
        ApiConstants.loginEndpoint,
        data: {
          'phone': phoneNumber,
          'password': password,
        },
      );
      return UserModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception(_extractErrorMessage(e));
    }
  }

  @override
  Future<UserModel> signUp(String name, String phoneNumber, String password) async {
    try {
      final response = await dio.post(
        ApiConstants.registerEndpoint,
        data: {
          'name': name,
          'phone': phoneNumber,
          'password': password,
        },
      );
      return UserModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception(_extractErrorMessage(e));
    }
  }

  @override
  Future<void> sendOtp(String phoneNumber) async {
    try {
      await dio.post(
        ApiConstants.forgotPasswordSendEndpoint,
        data: {
          'phone': phoneNumber,
        },
      );
    } on DioException catch (e) {
      throw Exception(_extractErrorMessage(e));
    }
  }

  @override
  Future<void> verifyOtp(String phoneNumber, String code) async {
    try {
      await dio.post(
        ApiConstants.forgotPasswordVerifyEndpoint,
        data: {
          'phone': phoneNumber,
          'code': code,
        },
      );
    } on DioException catch (e) {
      throw Exception(_extractErrorMessage(e));
    }
  }

  @override
  Future<void> resetPassword(String phoneNumber, String code, String newPassword) async {
    try {
      await dio.post(
        ApiConstants.forgotPasswordResetEndpoint,
        data: {
          'phone': phoneNumber,
          'code': code,
          'newPassword': newPassword,
        },
      );
    } on DioException catch (e) {
      throw Exception(_extractErrorMessage(e));
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await dio.post(ApiConstants.logoutEndpoint);
    } on DioException catch (e) {
      throw Exception(_extractErrorMessage(e));
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
