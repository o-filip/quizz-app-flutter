import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'extensions/colors_extension_theme_data.dart';

class QuizAppTheme {
  static ThemeData createTheme() => ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.purple,
          onPrimary: AppColors.white,
          secondary: AppColors.purple,
          onSecondary: AppColors.white,
          secondaryContainer: AppColors.purpleLight,
          error: AppColors.red,
          onError: AppColors.white,
          background: AppColors.white,
          onBackground: AppColors.black,
          surface: AppColors.white,
          onSurface: AppColors.black,
        ),
        extensions: <ThemeExtension<dynamic>>[
          ColorsExtensionThemeData(
            correctAnswer: AppColors.green,
            onCorrectAnswer: AppColors.white,
            incorrectAnswer: AppColors.red,
            onIncorrectAnswer: AppColors.white,
            likeIcon: AppColors.red,
          ),
        ],
        scaffoldBackgroundColor: AppColors.purple,
        appBarTheme: _createAppBarTheme(),
        cardTheme: _createCardTheme(),
        sliderTheme: _createSliderTheme(),
        dividerTheme: _createDividerTheme(),
        checkboxTheme: _createCheckboxTheme(),
        progressIndicatorTheme: _createProgressIndicatorTheme(),
      );

  static AppBarTheme _createAppBarTheme() => const AppBarTheme(
      backgroundColor: AppColors.purple,
      foregroundColor: AppColors.white,
      centerTitle: true);

  static CardTheme _createCardTheme() => const CardTheme(
        color: AppColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        margin: EdgeInsets.all(8),
      );

  static SliderThemeData _createSliderTheme() => const SliderThemeData(
        inactiveTrackColor: AppColors.purpleLight,
      );

  static DividerThemeData _createDividerTheme() => const DividerThemeData(
        thickness: 1,
        color: AppColors.purpleLight,
      );

  static CheckboxThemeData _createCheckboxTheme() => CheckboxThemeData(
        fillColor: MaterialStateProperty.all(AppColors.purpleLight),
        checkColor: MaterialStateProperty.all(AppColors.purple),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
        ),
      );

  static ProgressIndicatorThemeData _createProgressIndicatorTheme() =>
      const ProgressIndicatorThemeData(
          color: AppColors.purple,
          linearTrackColor: AppColors.purpleLight,
          linearMinHeight: 6,
          circularTrackColor: AppColors.purpleLight);
}
