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

    if (request.query!.trim().isEmpty) {
      emit(MapInitial());
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      emit(AutocompleteLoading());
      final result = await getAutocompleteUseCase(request: request);
      result.fold(
        (failure) => emit(AutocompleteError(failure.message)),
        (suggestions) => emit(AutocompleteSuccess(suggestions)),
      );
    });
  }

  Future<void> selectPlace(AutoPlaceDetailsRequest request) async {
    emit(PlaceDetailsLoading());
    final result = await getPlaceDetailsUseCase(request);
    result.fold(
      (failure) => emit(PlaceDetailsError(failure.message)),
      (details) => emit(PlaceDetailsSuccess(details)),
    );
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
