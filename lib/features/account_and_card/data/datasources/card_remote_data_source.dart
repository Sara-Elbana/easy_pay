import 'package:easy_pay_app/core/constants/api_constants.dart';
import 'package:easy_pay_app/core/network/api_service.dart';
import 'package:easy_pay_app/features/account_and_card/data/models/card_model.dart';

class CardRemoteDataSource {
  final ApiService apiService;

  CardRemoteDataSource(this.apiService);

  Future<List<CardModel>> getCards() async {
    final response = await apiService.get(ApiConstants.cardsEndpoint);
    return CardModel.listFromJson(response.data);
  }
  Future<void> deleteCard(int cardId) async {
    await apiService.delete('${ApiConstants.cardsEndpoint}/$cardId');
  }
}