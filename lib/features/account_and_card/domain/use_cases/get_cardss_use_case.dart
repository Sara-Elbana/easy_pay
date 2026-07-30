import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/account_and_card/domain/entities/card_entity.dart';
import 'package:easy_pay_app/features/account_and_card/domain/repository_interface/card_repository_interface.dart';

class GetCardssUseCase {
  final CardRepository repository;

  GetCardssUseCase(this.repository);

  Future<ApiResult<List<CardEntity>>> call() async {
    return await repository.getCards();
  }
}
