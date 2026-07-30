import 'package:easy_pay_app/features/interest_rate/domain/entities/interest_rate.dart';
import 'package:equatable/equatable.dart';

abstract class InterestState extends Equatable {
  const InterestState();

  @override
  List<Object?> get props => [];
}

class InterestInitial extends InterestState {
  const InterestInitial();
}

class InterestLoading extends InterestState {
  const InterestLoading();
}

class InterestSuccess extends InterestState {
  final List<InterestRate> interestRates;

  const InterestSuccess(this.interestRates);

  @override
  List<Object?> get props => [interestRates];
}

class InterestFailure extends InterestState {
  final String errorMessage;

  const InterestFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}