import 'package:dartz/dartz.dart';
import 'package:easy_pay_app/core/errors/exceptions.dart';
import 'package:easy_pay_app/core/errors/failures.dart';
import 'package:easy_pay_app/features/account_and_card/data/datasources/add_card_remote_data_source.dart';
import 'package:easy_pay_app/features/account_and_card/data/datasources/card_remote_data_source.dart';
import 'package:easy_pay_app/features/account_and_card/domain/entities/card_entity.dart';
import 'package:easy_pay_app/features/account_and_card/domain/repository_interface/card_repository_interface.dart';

class CardRepositoryImpl implements CardRepository {
  final CardRemoteDataSource remoteDataSource;
  final AddCardRemoteDataSource addCardRemoteDataSource;


  CardRepositoryImpl(this.remoteDataSource, this.addCardRemoteDataSource);

  @override
  Future<Either<Failure, List<CardEntity>>> getCards() async {
    try {
      final remoteCards = await remoteDataSource.getCards();
      return Right(remoteCards);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, CardEntity>> addCard(Map<String, dynamic> cardData) async {
    try {
      final newCard = await addCardRemoteDataSource.addCard(cardData);
      return Right(newCard);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
  @override
  Future<Either<Failure, void>> deleteCard(int cardId) async {
    try {
      await remoteDataSource.deleteCard(cardId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}