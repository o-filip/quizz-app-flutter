// import 'package:json_annotation/json_annotation.dart';

import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../ui/theme/app_icons.dart';

enum Category {
  @JsonValue('General Knowledge')
  generalKnowledge,
  @JsonValue('Arts & Literature')
  artsAndLiterature,
  @JsonValue('Film & TV')
  filmAndTv,
  @JsonValue('Food & Drink')
  foodAndDrink,
  @JsonValue('Geography')
  geography,
  @JsonValue('History')
  history,
  @JsonValue('Music')
  music,
  @JsonValue('Science')
  science,
  @JsonValue('Society & Culture')
  societyAndCulture,
  @JsonValue('Sport & Leisure')
  sportAndLeisure;

  String toUserString(BuildContext context) => switch (this) {
        Category.generalKnowledge => S.of(context).category_general_knowledge,
        Category.artsAndLiterature =>
          S.of(context).category_arts_and_literature,
        Category.filmAndTv => S.of(context).category_film_and_tv,
        Category.foodAndDrink => S.of(context).category_food_and_drink,
        Category.geography => S.of(context).category_geography,
        Category.history => S.of(context).category_history,
        Category.music => S.of(context).category_music,
        Category.science => S.of(context).category_science,
        Category.societyAndCulture =>
          S.of(context).category_society_and_culture,
        Category.sportAndLeisure => S.of(context).category_sport_and_leisure,
      };

  String getIcon() => switch (this) {
        Category.generalKnowledge => AppIcons.categoryGeneralKnowledge,
        Category.artsAndLiterature => AppIcons.categoryArt,
        Category.filmAndTv => AppIcons.categoryFilm,
        Category.foodAndDrink => AppIcons.categoryFood,
        Category.geography => AppIcons.categoryGeography,
        Category.history => AppIcons.categoryHistory,
        Category.music => AppIcons.categoryMusic,
        Category.science => AppIcons.categoryScience,
        Category.societyAndCulture => AppIcons.categorySociety,
        Category.sportAndLeisure => AppIcons.categorySport,
      };
}

String encodeCategoriesListToJson(List<Category> categories) =>
    json.encode(categories.map((e) => e.toString()).toList());

List<Category> decodeCategoriesListFromJson(String categories) =>
    (json.decode(categories) as List<dynamic>)
        .map((e) =>
            Category.values.firstWhere((element) => element.toString() == e))
        .toList();
