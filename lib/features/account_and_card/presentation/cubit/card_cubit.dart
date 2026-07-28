import 'package:easy_pay_app/features/account_and_card/domain/use_cases/add_card_use_case.dart';
import 'package:easy_pay_app/features/account_and_card/domain/use_cases/delete_card_use_case.dart';
import 'package:easy_pay_app/features/account_and_card/domain/use_cases/get_cardss_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_pay_app/features/account_and_card/presentation/cubit/card_state.dart';

class CardCubit extends Cubit<CardState> {
  final GetCardssUseCase getCardssUseCase;
  final AddCardUseCase addCardUseCase;
  final DeleteCardUseCase deleteCardUseCase;

  CardCubit(this.getCardssUseCase, this.addCardUseCase, this.deleteCardUseCase)
      : super(CardInitial());

  Future<void> loadCards() async {
    emit(CardLoading());
    final result = await getCardssUseCase();
    if (isClosed) return;
    result.fold(
      (failure) => emit(CardError(failure.message)),
      (cards) => emit(CardSuccess(cards)),
    );
  }

  Future<bool> addNewCard(Map<String, dynamic> cardData) async {
    emit(CardLoading());
    final result = await addCardUseCase(cardData);
    if (isClosed) return false;
    return result.fold(
      (failure) {
        if (!isClosed) emit(CardError(failure.message));
        return false;
      },
      (newCard) async {
        await loadCards();
        return true;
      },
    );
  }

  Future<void> removeCard(int cardId) async {
    emit(CardLoading());
    final result = await deleteCardUseCase(cardId);
    if (isClosed) return;
    result.fold(
      (failure) {
        if (!isClosed) emit(CardError(failure.message));
      },
      (_) async {
        await loadCards();
      },
    );
  }
}
