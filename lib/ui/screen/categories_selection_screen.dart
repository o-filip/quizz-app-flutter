import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/enum/category.dart';
import '../navigation/query_params_ext.dart';
import '../widget/animated_floating_button.dart';
import '../widget/category_select_card.dart';

class CategoriesSelectionRoute {
  static const path = '/categories-selection';

  static Uri uri({
    List<Category>? preselectedCategories,
  }) =>
      Uri(
        path: path,
        queryParameters: {
          'preselectedCategories':
              preselectedCategories?.encodeEnumListToUriQuery() ?? [],
        },
      );

  static CategoriesSelectionScreen fromUri(Uri uri) {
    final preselectedCategories =
        uri.decodeEnumList('preselectedCategories', Category.values);

    return CategoriesSelectionScreen(
      preselectedCategories: preselectedCategories ?? [],
    );
  }
}

class CategoriesSelectionScreen extends StatefulWidget {
  const CategoriesSelectionScreen({
    super.key,
    required this.preselectedCategories,
  });

  final List<Category> preselectedCategories;

  @override
  State<StatefulWidget> createState() => CategoriesSelectionScreenState();
}

class CategoriesSelectionScreenState extends State<CategoriesSelectionScreen> {
  late List<Category> _selectedCategories;
  bool _didSelectionChange = false;

  @override
  void initState() {
    super.initState();
    _selectedCategories = widget.preselectedCategories;
  }

  void _onSelectionChanged(Category category, bool isSelected) {
    setState(() {
      _didSelectionChange = true;

      if (isSelected) {
        _selectedCategories.add(category);
      } else {
        _selectedCategories.remove(category);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).categories_selection_app_bar_title),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) => CategorySelectCard(
                  category: Category.values[index],
                  isSelected:
                      _selectedCategories.contains(Category.values[index]),
                  onSelectionChanged: (isSelected) => _onSelectionChanged(
                    Category.values[index],
                    isSelected,
                  ),
                ),
                itemCount: Category.values.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: AnimatedFloatingButton(
        onPressed: () {
          Navigator.of(context).pop(_selectedCategories);
        },
        isHidden: !_didSelectionChange,
        child: const Icon(Icons.check),
      ),
    );
  }
}
