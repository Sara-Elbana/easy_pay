import 'package:easy_pay_app/core/constants/api_constants.dart';
import 'package:easy_pay_app/core/network/api_service.dart';
import 'package:easy_pay_app/features/account_and_card/data/models/card_model.dart';

class AddCardRemoteDataSource {
  final ApiService apiService;

  AddCardRemoteDataSource(this.apiService);

  Future<CardModel> addCard(Map<String, dynamic> cardData) async {
    final response = await apiService.post(
      ApiConstants.cardsEndpoint,
      data: cardData,
    );
    return CardModel.fromJson(response.data);
  }
}
