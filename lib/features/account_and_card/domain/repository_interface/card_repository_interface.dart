import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/account_and_card/domain/entities/card_entity.dart';

abstract class CardRepository {
  Future<ApiResult<List<CardEntity>>> getCards();
  Future<ApiResult<CardEntity>> addCard(Map<String, dynamic> cardData);
  Future<ApiResult<bool>> deleteCard(int cardId);
}