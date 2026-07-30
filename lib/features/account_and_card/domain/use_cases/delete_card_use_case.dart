import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/account_and_card/data/models/requests/delete_card_request.dart';
import 'package:easy_pay_app/features/account_and_card/domain/repository_interface/card_repository_interface.dart';

class DeleteCardUseCase {
  final CardRepository repository;

  DeleteCardUseCase(this.repository);

  Future<ApiResult<bool>> call(DeleteCardRequest request) async {
    return await repository.deleteCard(request);
  }
}