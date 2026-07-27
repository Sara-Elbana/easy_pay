import 'dart:async';
import 'package:easy_pay_app/features/Branch/domain/entities/auto__place_details_request.dart';
import 'package:easy_pay_app/features/Branch/domain/entities/auto_complete_request.dart';
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

  void searchPlaces(AutoCompleteRequest request) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    if (request.query.trim().isEmpty) {
      emit(MapInitial());
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      emit(AutocompleteLoading());
      try {
        final suggestions = await getAutocompleteUseCase(request: request);
        emit(AutocompleteSuccess(suggestions));
      } catch (e) {
        emit(AutocompleteError(e.toString()));
      }
    });
  }

  Future<void> selectPlace(AutoPlaceDetailsRequest request) async {
    emit(PlaceDetailsLoading());
    try {
      final details = await getPlaceDetailsUseCase(request);
      emit(PlaceDetailsSuccess(details));
    } catch (e) {
      emit(PlaceDetailsError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
