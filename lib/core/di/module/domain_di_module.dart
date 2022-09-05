import '../../../domain/use_case/get_random_question_use_case.dart';
import '../../../domain/use_case/get_random_quiz_use_case.dart';
import '../../../domain/use_case/get_stored_questions_use_case.dart';
import '../../../domain/use_case/toggle_question_like_use_case.dart';
import '../di.dart';

class DomainDiModule {
  static void register() {
    _registerUseCases();
  }

  static void _registerUseCases() {
    getIt.registerFactory<GetRandomQuestionUseCase>(
      () => GetRandomQuestionUseCaseImpl(
        questionRepository: getIt(),
        answersPermutationUtils: getIt(),
      ),
    );

    getIt.registerFactory<GetRandomQuizUseCase>(
      () => GetRandomQuizUseCaseImpl(
        quizRepository: getIt(),
        answersPermutationUtils: getIt(),
      ),
    );

    getIt.registerFactory<GetStoredQuestionsUseCase>(
      () => GetStoredQuestionsUseCaseImpl(
        quizRepository: getIt(),
      ),
    );

    getIt.registerFactory<ToggleQuestionLikeUseCase>(
      () => ToggleQuestionLikeUseCaseImpl(
        quizRepository: getIt(),
      ),
    );
  }
}
