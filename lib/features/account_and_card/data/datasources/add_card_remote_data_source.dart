import 'package:dio/dio.dart';
import 'package:easy_pay_app/core/constants/api_constants.dart';
import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/core/network/api_service.dart';
import 'package:easy_pay_app/features/account_and_card/data/models/card_model.dart';

class AddCardRemoteDataSource {
  final ApiService apiService;

  AddCardRemoteDataSource(this.apiService);

  Future<ApiResult<CardModel>> addCard(Map<String, dynamic> cardData) async {
    try {
      final response = await apiService.post(
        ApiConstants.cardsEndpoint,
        data: cardData,
      );
      if (response.data == null) {
        return const ApiFailure(error: 'Invalid response format');
      }
      final model = CardModel.fromJson(response.data as Map<String, dynamic>);
      return ApiSuccess(data: model);
    } on DioException catch (e) {
      return ApiFailure(
        error: e.response?.data['message'] ??
            e.message ??
            ApiConstants.unknownError,
      );
    } catch (_) {
      return const ApiFailure(error: ApiConstants.unknownError);
    }
  }
}
