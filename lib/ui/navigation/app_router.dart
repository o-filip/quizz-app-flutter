import 'package:go_router/go_router.dart';

import '../screen/categories_selection_screen.dart';
import '../screen/home/home_screen.dart';
import '../screen/quiz/quiz_screen.dart';
import '../screen/stored_questions/stored_questions_list_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: HomeRoute.path,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: CategoriesSelectionRoute.path,
      builder: (context, state) => CategoriesSelectionRoute.fromUri(state.uri),
    ),
    GoRoute(
      path: QuizRoute.path,
      builder: (context, state) => QuizRoute.fromUri(state.uri),
    ),
    GoRoute(
      path: StoredQuestionsListRoute.path,
      builder: (context, state) => const StoredQuestionsListScreen(),
    ),
  ],
);
