import 'package:dio/dio.dart';
import 'package:easy_pay_app/core/constants/api_constants.dart';
import 'package:easy_pay_app/core/di/service_locator.dart';
import 'package:easy_pay_app/features/account_and_card/data/models/card_model.dart';

class AddCardRemoteDataSource {
  final Dio dio;

  AddCardRemoteDataSource(): dio = getIt<Dio>();
  Future<CardModel> addCard(Map<String, dynamic> cardData) async {
    final response = await dio.post(ApiConstants.cardsEndpoint, data: cardData,);
    final data = response.data;
    final cardJson =
        data is Map && data.containsKey('card') ? data['card'] : data;
    return CardModel.fromJson(cardJson);
  }
}
