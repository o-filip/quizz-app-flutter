import 'package:go_router/go_router.dart';

import 'route/categories_selection_route.dart';
import 'route/home_route.dart';
import 'route/quiz_route.dart';
import 'route/stored_questions_list_route.dart';

final router = GoRouter(
  routes: [
    HomeGoRoute.generate([
      QuizGoRoute.generate(),
      StoredQuestionsListGoRoute.generate(),
    ]),
    CategoriesSelectionGoRoute.generate(),
  ],
);
