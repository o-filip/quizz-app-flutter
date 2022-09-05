import 'package:flutter/material.dart';

import '../../core/enum/difficulty.dart';
import '../../localization/l10n.dart';

class DifficultyDropdownButton extends StatelessWidget {
  const DifficultyDropdownButton({
    super.key,
    this.value,
    required this.onChanged,
  });

  final Difficulty? value;
  final void Function(Difficulty?) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Difficulty?>(
      isExpanded: true,
      value: value,
      items: [
        null,
        ...Difficulty.values,
      ]
          .map(
            (e) => DropdownMenuItem<Difficulty?>(
              value: e,
              child: Row(
                children: [
                  const Icon(Icons.speed),
                  const SizedBox(width: 8),
                  Text(
                    e?.toUserString(context) ?? S.of(context).difficult_any,
                  ),
                ],
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}
