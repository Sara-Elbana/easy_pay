import 'package:easy_pay_app/features/Branch/domain/entities/place_details.dart';
import 'package:easy_pay_app/features/Branch/domain/entities/place_suggestion.dart';
import 'package:equatable/equatable.dart';

abstract class MapState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MapInitial extends MapState {}

class AutocompleteLoading extends MapState {}

class AutocompleteSuccess extends MapState {
  final List<PlaceSuggestion> suggestions;
  AutocompleteSuccess(this.suggestions);

  @override
  List<Object?> get props => [suggestions];
}

class AutocompleteError extends MapState {
  final String message;
  AutocompleteError(this.message);

  @override
  List<Object?> get props => [message];
}

class PlaceDetailsLoading extends MapState {}

class PlaceDetailsSuccess extends MapState {
  final PlaceDetails details;
  PlaceDetailsSuccess(this.details);

  @override
  List<Object?> get props => [details];
}

class PlaceDetailsError extends MapState {
  final String message;
  PlaceDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}