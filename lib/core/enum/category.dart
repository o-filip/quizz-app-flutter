// import 'package:json_annotation/json_annotation.dart';

import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../localization/l10n.dart';
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

  String toUserString(BuildContext context) {
    switch (this) {
      case Category.generalKnowledge:
        return S.of(context).category_general_knowledge;
      case Category.artsAndLiterature:
        return S.of(context).category_arts_and_literature;
      case Category.filmAndTv:
        return S.of(context).category_film_and_tv;
      case Category.foodAndDrink:
        return S.of(context).category_food_and_drink;
      case Category.geography:
        return S.of(context).category_geography;
      case Category.history:
        return S.of(context).category_history;
      case Category.music:
        return S.of(context).category_music;
      case Category.science:
        return S.of(context).category_science;
      case Category.societyAndCulture:
        return S.of(context).category_society_and_culture;
      case Category.sportAndLeisure:
        return S.of(context).category_sport_and_leisure;
    }
  }

  String getIcon() {
    switch (this) {
      case Category.generalKnowledge:
        return AppIcons.categoryGeneralKnowledge;
      case Category.artsAndLiterature:
        return AppIcons.categoryArt;
      case Category.filmAndTv:
        return AppIcons.categoryFilm;
      case Category.foodAndDrink:
        return AppIcons.categoryFood;
      case Category.geography:
        return AppIcons.categoryGeography;
      case Category.history:
        return AppIcons.categoryHistory;
      case Category.music:
        return AppIcons.categoryMusic;
      case Category.science:
        return AppIcons.categoryScience;
      case Category.societyAndCulture:
        return AppIcons.categorySociety;
      case Category.sportAndLeisure:
        return AppIcons.categorySport;
    }
  }
}

String encodeCategoriesListToJson(List<Category> categories) =>
    json.encode(categories.map((e) => e.toString()).toList());

List<Category> decodeCategoriesListFromJson(String categories) =>
    (json.decode(categories) as List<dynamic>)
        .map((e) =>
            Category.values.firstWhere((element) => element.toString() == e))
        .toList();
