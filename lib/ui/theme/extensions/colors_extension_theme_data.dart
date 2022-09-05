import 'package:flutter/material.dart';

class ColorsExtensionThemeData
    extends ThemeExtension<ColorsExtensionThemeData> {
  ColorsExtensionThemeData({
    this.correctAnswer,
    this.onCorrectAnswer,
    this.incorrectAnswer,
    this.onIncorrectAnswer,
    this.likeIcon,
  });

  final Color? correctAnswer;
  final Color? onCorrectAnswer;
  final Color? incorrectAnswer;
  final Color? onIncorrectAnswer;
  final Color? likeIcon;

  @override
  ThemeExtension<ColorsExtensionThemeData> copyWith({
    Color? correctAnswer,
    Color? onCorrectAnswer,
    Color? incorrectAnswer,
    Color? onIncorrectAnswer,
    Color? likeIcon,
  }) {
    return ColorsExtensionThemeData(
      correctAnswer: correctAnswer ?? this.correctAnswer,
      onCorrectAnswer: onCorrectAnswer ?? this.onCorrectAnswer,
      incorrectAnswer: incorrectAnswer ?? this.incorrectAnswer,
      onIncorrectAnswer: onIncorrectAnswer ?? this.onIncorrectAnswer,
      likeIcon: likeIcon ?? this.likeIcon,
    );
  }

  @override
  ThemeExtension<ColorsExtensionThemeData> lerp(
      covariant ThemeExtension<ColorsExtensionThemeData>? other, double t) {
    if (other is ColorsExtensionThemeData) {
      return ColorsExtensionThemeData(
        correctAnswer: Color.lerp(correctAnswer, other.correctAnswer, t),
        onCorrectAnswer: Color.lerp(onCorrectAnswer, other.onCorrectAnswer, t),
        incorrectAnswer: Color.lerp(incorrectAnswer, other.incorrectAnswer, t),
        onIncorrectAnswer:
            Color.lerp(onIncorrectAnswer, other.onIncorrectAnswer, t),
        likeIcon: Color.lerp(likeIcon, other.likeIcon, t),
      );
    } else {
      return this;
    }
  }
}
