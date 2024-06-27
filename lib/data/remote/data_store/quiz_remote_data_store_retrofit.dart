import '../../../core/enum/category.dart';
import '../../../core/enum/difficulty.dart';
import '../model/question_remote_model.dart';
import '../retrofit/data_store/base_retrofit_data_store.dart';
import '../retrofit/service/quiz_ws_service.dart';
import 'quiz_remote_data_store.dart';

class QuizRemoteDataStoreImpl extends QuizRemoteDataStore
    with BaseRetrofitDataStore {
  QuizRemoteDataStoreImpl({
    required this.quizWsService,
  });

  final QuizWsService quizWsService;

  @override
  Future<List<QuestionRemoteModel>> getQuiz({
    List<Category>? categories,
    required int limit,
    String region = 'CZ',
    Difficulty? difficulty,
  }) =>
      fetch(() => quizWsService.getQuiz(
            categories:
                categories?.map((e) => _categoryToQueryParameter(e)).join(','),
            limit: limit,
            region: region,
            difficulty: _difficultyToQueryParameter(difficulty),
          ));

  String _categoryToQueryParameter(Category category) => switch (category) {
        Category.generalKnowledge => 'general_knowledge',
        Category.artsAndLiterature => 'arts_and_literature',
        Category.filmAndTv => 'film_and_tv',
        Category.foodAndDrink => 'food_and_drink',
        Category.geography => 'geography',
        Category.history => 'history',
        Category.music => 'music',
        Category.science => 'science',
        Category.societyAndCulture => 'society_and_culture',
        Category.sportAndLeisure => 'sport_and_leisure',
      };

  String? _difficultyToQueryParameter(Difficulty? difficulty) =>
      switch (difficulty) {
        Difficulty.easy => 'easy',
        Difficulty.medium => 'medium',
        Difficulty.hard => 'hard',
        null => null,
      };
}
