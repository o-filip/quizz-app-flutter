import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../core/enum/category.dart';
import '../../localization/l10n.dart';
import '../navigation/app_router.dart';

class CategoriesSelectionInput extends StatelessWidget {
  const CategoriesSelectionInput({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final List<Category>? value;
  final void Function(List<Category>) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            S.of(context).categories_selection_input_label,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        InkWell(
          onTap: () => _onTap(context),
          child: _buildFieldContent(context),
        ),
      ],
    );
  }

  Future<void> _onTap(BuildContext context) async {
    final result = await context.pushRoute<List<Category>?>(
      CategoriesSelectionRoute(
        preselectedCategories: value ?? [],
      ),
    );

    if (result != null) {
      onChanged(result);
    }
  }

  Widget _buildFieldContent(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 48),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Icon(
                Icons.category_outlined,
                color: Theme.of(context).inputDecorationTheme.prefixIconColor,
              ),
            ),
            Expanded(
              child: Text(_generateInputText(context),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Theme.of(context).inputDecorationTheme.suffixIconColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _generateInputText(BuildContext context) {
    if (value == null || value!.isEmpty) {
      return S.of(context).categories_selection_input_all_categories;
    } else if (value!.length == 1) {
      return value!.first.toUserString(context);
    } else {
      return S
          .of(context)
          .categories_selection_input_selected_count(value!.length);
    }
  }
}
