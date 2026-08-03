import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/account_and_card/data/datasources/add_card_remote_data_source.dart';
import 'package:easy_pay_app/features/account_and_card/data/datasources/card_remote_data_source.dart';
import 'package:easy_pay_app/features/account_and_card/data/models/card_model.dart';
import 'package:easy_pay_app/features/account_and_card/data/models/requests/add_card_request.dart';
import 'package:easy_pay_app/features/account_and_card/data/models/requests/delete_card_request.dart';
import 'package:easy_pay_app/features/account_and_card/domain/entities/card_entity.dart';
import 'package:easy_pay_app/features/account_and_card/domain/repository_interface/card_repository_interface.dart';

class CardRepositoryImpl implements CardRepository {
  final CardRemoteDataSource remoteDataSource;
  final AddCardRemoteDataSource addCardRemoteDataSource;

  CardRepositoryImpl(this.remoteDataSource, this.addCardRemoteDataSource);

  @override
  Future<ApiResult<List<CardEntity>>> getCards() async {
    final result = await remoteDataSource.getCards();
    if (result is ApiSuccess<List<CardModel>>) {
      return ApiSuccess(data: result.data, message: result.message);
    }
    final failure = result as ApiFailure<List<CardModel>>;
    return ApiFailure(error: failure.error, message: failure.message);
  }

  @override
  Future<ApiResult<CardEntity>> addCard(AddCardRequest request) async {
    final result = await addCardRemoteDataSource.addCard(request);
    if (result is ApiSuccess<CardModel>) {
      return ApiSuccess(data: result.data, message: result.message);
    }
    final failure = result as ApiFailure<CardModel>;
    return ApiFailure(error: failure.error, message: failure.message);
  }

  @override
  Future<ApiResult<bool>> deleteCard(DeleteCardRequest request) async {
    final result = await remoteDataSource.deleteCard(request);
    if (result is ApiSuccess<bool>) {
      return ApiSuccess(data: result.data, message: result.message);
    }
    final failure = result as ApiFailure<bool>;
    return ApiFailure(error: failure.error, message: failure.message);
  }
}
