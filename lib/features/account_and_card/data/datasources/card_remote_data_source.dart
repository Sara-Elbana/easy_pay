import 'package:dio/dio.dart';
import 'package:easy_pay_app/core/constants/api_constants.dart';
import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/core/network/api_service.dart';
import 'package:easy_pay_app/features/account_and_card/data/models/card_model.dart';
import 'package:easy_pay_app/features/account_and_card/data/models/requests/delete_card_request.dart';

class CardRemoteDataSource {
  final ApiService apiService;

  CardRemoteDataSource(this.apiService);

  Future<ApiResult<List<CardModel>>> getCards() async {
    try {
      final response = await apiService.get(ApiConstants.cardsEndpoint);
      if (response.data == null) {
        return const ApiFailure(error: 'Invalid response format');
      }
      final models = CardModel.listFromJson(response.data);
      return ApiSuccess(data: models);
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

  Future<ApiResult<bool>> deleteCard(DeleteCardRequest request) async {
    try {
      await apiService.delete('${ApiConstants.cardsEndpoint}/${request.cardId}');
      return const ApiSuccess(data: true);
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