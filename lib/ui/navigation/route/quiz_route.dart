import 'package:collection/collection.dart';
import 'package:go_router/go_router.dart';

import '../../../core/enum/category.dart';
import '../../../core/enum/difficulty.dart';
import '../../screen/quiz/quiz_screen.dart';

class QuizGoRoute {
  static const String path = 'quiz';

  static GoRoute generate() {
    return GoRoute(
      path: path,
      builder: (context, state) {
        return QuizScreen(
          difficulty: _parseDifficultyQueryParam(state),
          categories: _parseCategoriesQueryParam(state),
          numOfQuestions: _parseNumOfQuestionsQueryParam(state),
        );
      },
    );
  }

  static Difficulty? _parseDifficultyQueryParam(GoRouterState state) {
    final difficulty = state.queryParameters['difficulty'];
    return Difficulty.values.firstWhereOrNull(
      (d) => d.toString() == difficulty,
    );
  }

  static List<Category> _parseCategoriesQueryParam(GoRouterState state) {
    final categories = state.queryParameters['categories'];
    return decodeCategoriesListFromJson(categories!);
  }

  static int _parseNumOfQuestionsQueryParam(GoRouterState state) {
    final numOfQuestions = state.queryParameters['numOfQuestions'];
    return int.parse(numOfQuestions!);
  }

  static String route({
    Difficulty? difficulty,
    required List<Category> categories,
    required int numOfQuestions,
  }) =>
      '/${Uri(
        path: path,
        queryParameters: {
          'difficulty': difficulty?.toString(),
          'categories': encodeCategoriesListToJson(categories),
          'numOfQuestions': numOfQuestions.toString(),
        },
      )}';
}
