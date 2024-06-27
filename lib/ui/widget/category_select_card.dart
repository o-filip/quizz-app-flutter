import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/enum/category.dart';

class CategorySelectCard extends StatelessWidget {
  const CategorySelectCard({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onSelectionChanged,
  });

  final Category category;
  final bool isSelected;
  final Function(bool newState) onSelectionChanged;

  static const _animationDuration = Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          onSelectionChanged(!isSelected);
        },
        child: AnimatedContainer(
          color: isSelected
              ? Theme.of(context).colorScheme.secondaryContainer
              : Theme.of(context).colorScheme.surface,
          duration: _animationDuration,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: _buildCheckMark(context),
              ),
              Center(
                child: _buildCardContent(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckMark(BuildContext context) {
    return AnimatedOpacity(
      duration: _animationDuration,
      opacity: isSelected ? 1 : 0,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(
          Icons.check_circle,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildCardContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          category.getIcon(),
          height: 70,
          width: 70,
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Text(
            category.toUserString(context),
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
