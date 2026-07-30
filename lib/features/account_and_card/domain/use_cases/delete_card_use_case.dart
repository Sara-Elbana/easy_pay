import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/account_and_card/domain/repository_interface/card_repository_interface.dart';

class DeleteCardUseCase {
  final CardRepository repository;

  DeleteCardUseCase(this.repository);

  Future<ApiResult<bool>> call(int cardId) async {
    return await repository.deleteCard(cardId);
  }
}