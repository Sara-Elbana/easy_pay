import 'package:dio/dio.dart';
import 'package:easy_pay_app/core/constants/api_constants.dart';
import 'package:easy_pay_app/features/account_and_card/data/models/card_model.dart';

class CardRemoteDataSource {
  final Dio dio;

  CardRemoteDataSource(this.dio);

  Future<List<CardModel>> getCards() async {
    final response = await dio.get(ApiConstants.cardsEndpoint);
    final data = response.data;
    List cardsList = data is Map ? data['cards'] ?? [] : data;
    return cardsList.map((json) => CardModel.fromJson(json)).toList();
  }

  Future<void> deleteCard(int cardId) async {
    await dio.delete('https://ebank.dotlaa.com/api/cards/$cardId');
  }
}