import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/enum/category.dart';
import '../../screen/categories_selection_screen.dart';

class CategoriesSelectionGoRoute {
  static const path = '/categories-selection';

  static GoRoute generate() => GoRoute(
        path: CategoriesSelectionGoRoute.path,
        builder: (context, state) => CategoriesSelectionScreen(
          preselectedCategories: _parseSelectedCategoriesQueryParam(state),
        ),
        pageBuilder: (context, state) => MaterialPage<List<Category>?>(
          key: state.pageKey,
          fullscreenDialog: true,
          child: CategoriesSelectionScreen(
            preselectedCategories: _parseSelectedCategoriesQueryParam(state),
          ),
        ),
      );

  static List<Category> _parseSelectedCategoriesQueryParam(
    GoRouterState state,
  ) =>
      decodeCategoriesListFromJson(
        state.queryParameters['preselectedCategories']!,
      );

  static String route(List<Category> preselectedCategories) => Uri(
        path: path,
        queryParameters: {
          'preselectedCategories':
              encodeCategoriesListToJson(preselectedCategories),
        },
      ).toString();
}
