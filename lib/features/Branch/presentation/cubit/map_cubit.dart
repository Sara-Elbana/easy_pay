import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_autocomplete_usecase.dart';
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
      final result = await getAutocompleteUseCase(query);
      result.fold(
        (failure) => emit(AutocompleteError(failure.message)),
        (suggestions) => emit(AutocompleteSuccess(suggestions)),
      );
    });
  }

  Future<void> selectPlace(String placeId) async {
    emit(PlaceDetailsLoading());
    final result = await getPlaceDetailsUseCase(placeId);
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
