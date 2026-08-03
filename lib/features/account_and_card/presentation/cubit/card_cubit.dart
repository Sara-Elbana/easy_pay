import 'package:easy_pay_app/core/cubit/base_state.dart';
import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/account_and_card/data/models/requests/add_card_request.dart';
import 'package:easy_pay_app/features/account_and_card/data/models/requests/delete_card_request.dart';
import 'package:easy_pay_app/features/account_and_card/domain/entities/card_entity.dart';
import 'package:easy_pay_app/features/account_and_card/domain/use_cases/add_card_use_case.dart';
import 'package:easy_pay_app/features/account_and_card/domain/use_cases/delete_card_use_case.dart';
import 'package:easy_pay_app/features/account_and_card/domain/use_cases/get_cardss_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardCubit extends Cubit<BaseState<List<CardEntity>>> {
  final GetCardssUseCase getCardssUseCase;
  final AddCardUseCase addCardUseCase;
  final DeleteCardUseCase deleteCardUseCase;

  CardCubit(this.getCardssUseCase, this.addCardUseCase, this.deleteCardUseCase)
      : super(const BaseInitial());

  Future<void> loadCards({bool forceRefresh = false}) async {
    if (!forceRefresh && state is BaseSuccess<List<CardEntity>>) return;
    emit(const BaseLoading());
    final result = await getCardssUseCase();
    if (isClosed) return;
    if (result is ApiSuccess<List<CardEntity>>) {
      emit(BaseSuccess(result.data));
    } else if (result is ApiFailure<List<CardEntity>>) {
      emit(BaseError(result.error));
    }
  }

  void clear() {
    emit(const BaseInitial());
  }

  Future<bool> addNewCard(Map<String, dynamic> cardData) async {
    if (isClosed) return false;
    emit(const BaseLoading());
    final request = AddCardRequest(
      cardHolderName: cardData['card_holder_name'] ?? '',
      cardNumber: cardData['card_number'] ?? '',
      expirationDate: cardData['expiration_date'] ?? '',
      cardType: cardData['card_type'] ?? '',
    );
    final result = await addCardUseCase(request);
    if (isClosed) return false;
    if (result is ApiSuccess<CardEntity>) {
      await loadCards();
      return true;
    } else if (result is ApiFailure<CardEntity>) {
      if (!isClosed) emit(BaseError(result.error));
      return false;
    }
    return false;
  }

  Future<void> removeCard(int cardId) async {
    if (isClosed) return;
    emit(const BaseLoading());
    final request = DeleteCardRequest(cardId: cardId);
    final result = await deleteCardUseCase(request);
    if (isClosed) return;
    if (result is ApiSuccess<bool>) {
      await loadCards();
    } else if (result is ApiFailure<bool>) {
      if (!isClosed) emit(BaseError(result.error));
    }
  }
}
