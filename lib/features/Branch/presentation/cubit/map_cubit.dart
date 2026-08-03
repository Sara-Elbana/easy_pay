import 'dart:async';
import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/Branch/data/models/requests/auto_complete_request.dart';
import 'package:easy_pay_app/features/Branch/data/models/requests/auto_place_details_request.dart';
import 'package:easy_pay_app/features/Branch/domain/entities/place_details.dart';
import 'package:easy_pay_app/features/Branch/domain/entities/place_suggestion.dart';
import 'package:easy_pay_app/features/Branch/domain/usecases/get_autocomplete_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  final GetAutocompleteUseCase getAutocompleteUseCase;
  final GetPlaceDetailsUseCase getPlaceDetailsUseCase;
  Timer? _debounce;

  MapCubit({
    required this.getAutocompleteUseCase,
    required this.getPlaceDetailsUseCase,
  }) : super(MapInitial());

  void searchPlaces(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    if (query.trim().isEmpty) {
      emit(MapInitial());
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      emit(AutocompleteLoading());
      final request = AutoCompleteRequest(query: query);
      final result = await getAutocompleteUseCase(request);
      if (result is ApiSuccess<List<PlaceSuggestion>>) {
        emit(AutocompleteSuccess(result.data));
      } else if (result is ApiFailure<List<PlaceSuggestion>>) {
        emit(AutocompleteError(result.error));
      }
    });
  }

  Future<void> selectPlace(String placeId) async {
    emit(PlaceDetailsLoading());
    final request = AutoPlaceDetailsRequest(placeId: placeId);
    final result = await getPlaceDetailsUseCase(request);
    if (result is ApiSuccess<PlaceDetails>) {
      emit(PlaceDetailsSuccess(result.data));
    } else if (result is ApiFailure<PlaceDetails>) {
      emit(PlaceDetailsError(result.error));
    }
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}