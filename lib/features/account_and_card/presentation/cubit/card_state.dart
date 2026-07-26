import 'package:equatable/equatable.dart';
import 'package:easy_pay_app/features/account_and_card/domain/entities/card_entity.dart';

abstract class CardState extends Equatable {
  const CardState();

  @override
  List<Object> get props => [];
}

class CardInitial extends CardState {}

class CardLoading extends CardState {}

class CardSuccess extends CardState {
  final List<CardEntity> cards;

  const CardSuccess(this.cards);

  @override
  List<Object> get props => [cards];
}

class CardError extends CardState {
  final String message;

  const CardError(this.message);

  @override
  List<Object> get props => [message];
}
