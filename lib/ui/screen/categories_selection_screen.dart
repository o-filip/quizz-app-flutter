import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/enum/category.dart';
import '../../localization/l10n.dart';
import '../utils/dimensions.dart';
import '../widget/screen_horizontal_padding.dart';

@RoutePage<List<Category>?>()
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

  @override
  void initState() {
    _selectedCategories = widget.preselectedCategories;
    super.initState();
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
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) => _buildCategoryItem(
                  context,
                  Category.values[index],
                ),
                itemCount: Category.values.length,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ScreenHorizontalPadding.symmetricVertical(
                verticalPadding: Dimensions.vertSpacingSmall,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(_selectedCategories);
                  },
                  child:
                      Text(S.of(context).categories_selection_confirm_button),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(
    BuildContext context,
    Category category,
  ) {
    final isSelected = _selectedCategories.contains(category);

    return Card(
      color: _selectedCategories.contains(category)
          ? Theme.of(context).colorScheme.secondaryContainer
          : null,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          setState(() {
            if (isSelected) {
              _selectedCategories.remove(category);
            } else {
              _selectedCategories.add(category);
            }
          });
        },
        child: Stack(
          children: [
            if (isSelected)
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    Icons.check_circle,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    category.getIcon(),
                    height: 40,
                    width: 40,
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Text(
                      category.toUserString(context),
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
