import '../entities/transfer_card.dart';
import '../repositories/transfer_repository.dart';

class GetCardsUseCase {
  final TransferRepository repository;

  GetCardsUseCase(this.repository);

  Future<List<TransferCard>> call() async {
    return await repository.getCards();
  }
}
