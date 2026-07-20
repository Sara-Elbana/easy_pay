import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/features/Branch/domain/entities/auto__place_details_request.dart';
import 'package:easy_pay_app/features/Branch/domain/entities/auto_complete_request.dart';
import 'package:easy_pay_app/features/Branch/presentation/cubit/map_cubit.dart';
import 'package:easy_pay_app/features/Branch/presentation/cubit/map_state.dart';
import 'package:easy_pay_app/features/Branch/presentation/widgets/map_drag_handle.dart';
import 'package:easy_pay_app/features/Branch/presentation/widgets/map_initial_placeholder.dart';
import 'package:easy_pay_app/features/Branch/presentation/widgets/map_search_field.dart';
import 'package:easy_pay_app/features/Branch/presentation/widgets/map_suggestion_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MapDraggableSheet extends StatefulWidget {
  const MapDraggableSheet({super.key});

  @override
  State<MapDraggableSheet> createState() => _MapDraggableSheetState();
}

class _MapDraggableSheetState extends State<MapDraggableSheet> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.35,
      minChildSize: 0.15,
      maxChildSize: 0.85,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 15,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            children: [
              const MapDragHandle(),
              _buildSearchSection(),
              const SizedBox(height: 12),
              _buildCubitConsumer(scrollController),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSearchSection() {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: _searchController,
      builder: (context, value, _) {
        return MapSearchField(
          controller: _searchController,
          onChanged: (val) {
            context.read<MapCubit>().searchPlaces(AutoCompleteRequest(query: val));
          },
          onClear: () {
            _searchController.clear();
            context.read<MapCubit>().searchPlaces(const AutoCompleteRequest(query:""));
          },
        );
      },
    );
  }

  Widget _buildCubitConsumer(ScrollController scrollController) {
    return Expanded(
      child: BlocBuilder<MapCubit, MapState>(
        buildWhen: (previous, current) {
          return current is AutocompleteLoading ||
              current is AutocompleteSuccess ||
              current is AutocompleteError ||
              current is MapInitial;
        },
        builder: (context, state) {
          if (state is AutocompleteLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            );
          }

          if (state is AutocompleteSuccess) {
            return _buildSuggestionsList(state.suggestions, scrollController);
          }

          return MapInitialPlaceholder(scrollController: scrollController);
        },
      ),
    );
  }

  Widget _buildSuggestionsList(
      List<dynamic> suggestions,
      ScrollController scrollController,
      ) {
    return ListView.separated(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: suggestions.length,
      separatorBuilder: (_, __) => const Divider(
        height: 1,
        color: Color(0xFFEEEEEE),
      ),
      itemBuilder: (context, index) {
        final item = suggestions[index];
        return MapSuggestionItem(
          suggestion: item,
          onTap: () {
            FocusScope.of(context).unfocus();
            _searchController.text = item.mainText;
            final request = AutoPlaceDetailsRequest(placeId: item.placeId);
            context.read<MapCubit>().selectPlace(request);
          },
        );
      },
    );
  }
}