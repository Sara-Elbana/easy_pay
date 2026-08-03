import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/account_and_card/data/models/requests/add_card_request.dart';
import 'package:easy_pay_app/features/account_and_card/domain/entities/card_entity.dart';
import 'package:easy_pay_app/features/account_and_card/domain/repository_interface/card_repository_interface.dart';

class AddCardUseCase {
  final CardRepository repository;

  AddCardUseCase(this.repository);

  Future<ApiResult<CardEntity>> call(AddCardRequest request) async {
    return await repository.addCard(request);
  }
}