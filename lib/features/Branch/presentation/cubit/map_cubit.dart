import 'dart:async';
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
      try {
        final suggestions = await getAutocompleteUseCase(query);
        emit(AutocompleteSuccess(suggestions));
      } catch (e) {
        emit(AutocompleteError(e.toString().replaceAll('Exception: ', '')));
      }
    });
  }

  Future<void> selectPlace(String placeId) async {
    emit(PlaceDetailsLoading());
    try {
      final details = await getPlaceDetailsUseCase(placeId);
      emit(PlaceDetailsSuccess(details));
    } catch (e) {
      emit(PlaceDetailsError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
