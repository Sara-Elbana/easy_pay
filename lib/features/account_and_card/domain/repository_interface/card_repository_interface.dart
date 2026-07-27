import 'package:dartz/dartz.dart';
import 'package:easy_pay_app/core/errors/failures.dart';
import 'package:easy_pay_app/features/account_and_card/domain/entities/card_entity.dart';

abstract class CardRepository {
  Future<Either<Failure, List<CardEntity>>> getCards();
  Future<Either<Failure, CardEntity>> addCard(Map<String, dynamic> cardData);
  Future<Either<Failure, Unit>> deleteCard(int cardId);
}