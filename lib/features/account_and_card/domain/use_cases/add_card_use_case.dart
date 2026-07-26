import 'package:dartz/dartz.dart';
import 'package:easy_pay_app/core/errors/failures.dart';
import 'package:easy_pay_app/features/account_and_card/domain/entities/card_entity.dart';
import 'package:easy_pay_app/features/account_and_card/domain/repository_interface/card_repository_interface.dart';

class AddCardUseCase {
  final CardRepository repository;

  AddCardUseCase(this.repository);

  Future<Either<Failure, CardEntity>> call(Map<String, dynamic> cardData) async {
    return await repository.addCard(cardData);
  }
}