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

  String _categoryToQueryParameter(Category category) {
    switch (category) {
      case Category.generalKnowledge:
        return 'general_knowledge';
      case Category.artsAndLiterature:
        return 'arts_and_literature';
      case Category.filmAndTv:
        return 'film_and_tv';
      case Category.foodAndDrink:
        return 'food_and_drink';
      case Category.geography:
        return 'geography';
      case Category.history:
        return 'history';
      case Category.music:
        return 'music';
      case Category.science:
        return 'science';
      case Category.societyAndCulture:
        return 'society_and_culture';
      case Category.sportAndLeisure:
        return 'sport_and_leisure';
    }
  }

  String? _difficultyToQueryParameter(Difficulty? difficulty) {
    switch (difficulty) {
      case Difficulty.easy:
        return 'easy';
      case Difficulty.medium:
        return 'medium';
      case Difficulty.hard:
        return 'hard';
      case null:
        return null;
    }
  }
}
