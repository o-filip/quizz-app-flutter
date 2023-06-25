import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../core/enum/category.dart';
import '../../core/enum/difficulty.dart';
import '../screen/categories_selection_screen.dart';
import '../screen/home/home_screen.dart';
import '../screen/quiz/quiz_screen.dart';
import '../screen/stored_questions/stored_questions_list_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Screen,Route',
)
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
          initial: true,
        ),
        AutoRoute(
          page: CategoriesSelectionRoute.page,
        ),
        AutoRoute(
          page: QuizRoute.page,
        ),
        AutoRoute(
          page: StoredQuestionsListRoute.page,
        ),
      ];
}
