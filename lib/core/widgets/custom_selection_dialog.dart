import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:easy_pay_app/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomSelectionDialog<B extends StateStreamableSource<S>, S> extends StatelessWidget {
  final String title;
  final String selectedValue;
  final List<String> Function(S) itemsProvider;
  final String Function(S) searchQueryProvider;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String> onSelected;

  const CustomSelectionDialog({
    super.key,
    required this.title,
    required this.selectedValue,
    required this.itemsProvider,
    required this.searchQueryProvider,
    required this.onSearchChanged,
    required this.onSelected,
  });

  static Future<void> show<B extends StateStreamableSource<S>, S>({
    required BuildContext context,
    required B cubit,
    required String title,
    required String selectedValue,
    required List<String> Function(S) itemsProvider,
    required String Function(S) searchQueryProvider,
    required ValueChanged<String> onSearchChanged,
    required ValueChanged<String> onSelected,
    VoidCallback? onDismissed,
  }) {
    return showDialog(
      context: context,
      builder: (dialogContext) {
        return BlocProvider.value(
          value: cubit,
          child: CustomSelectionDialog<B, S>(
            title: title,
            selectedValue: selectedValue,
            itemsProvider: itemsProvider,
            searchQueryProvider: searchQueryProvider,
            onSearchChanged: onSearchChanged,
            onSelected: onSelected,
          ),
        );
      },
    ).then((_) {
      if (onDismissed != null) {
        onDismissed();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<B>();
    final searchController = TextEditingController();
    searchController.text = searchQueryProvider(cubit.state);
    searchController.selection = TextSelection.collapsed(offset: searchController.text.length);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.scaleWidth(24)),
      ),
      backgroundColor: Colors.white,
      child: Container(
        width: context.pctWidth(0.85),
        height: context.pctHeight(0.6),
        padding: EdgeInsets.all(context.scaleWidth(24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: context.scaleWidth(18),
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            SizedBox(height: context.scaleHeight(16)),
            CustomTextField(
              controller: searchController,
              hintText: 'search'.tr(),
              onChanged: onSearchChanged,
              prefixIcon: const Icon(Icons.search, color: AppColors.textLight),
            ),
            SizedBox(height: context.scaleHeight(16)),
            Expanded(
              child: BlocBuilder<B, S>(
                builder: (context, state) {
                  final filteredItems = itemsProvider(state);
                  return ListView.separated(
                    itemCount: filteredItems.length,
                    separatorBuilder: (context, index) => const Divider(
                      color: AppColors.gray100,
                      height: 1,
                    ),
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      final isSelected = item.toLowerCase() == selectedValue.toLowerCase();

                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          item,
                          style: TextStyle(
                            fontSize: context.scaleWidth(15),
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                            color: isSelected ? AppColors.primary : AppColors.textDark,
                          ),
                        ),
                        trailing: isSelected
                            ? Icon(
                                Icons.check,
                                color: AppColors.primary,
                                size: context.scaleWidth(20),
                              )
                            : null,
                        onTap: () {
                          onSelected(item);
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
