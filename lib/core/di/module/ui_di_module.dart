import '../../../ui/bloc/quiz/quiz_bloc.dart';
import '../../../ui/bloc/random_question/random_question_bloc.dart';
import '../../../ui/bloc/stored_questions/filter/stored_questions_filter_cubit.dart';
import '../../../ui/bloc/stored_questions/list/stored_questions_list_bloc.dart';
import '../../../ui/bloc/toggle_question_like/toggle_question_like_cubit.dart';
import '../di.dart';

class UiDiModule {
  static void register() {
    _registerBlocs();
  }

  static void _registerBlocs() {
    getIt.registerFactory(
      () => QuizBloc(
        getRandomQuizUseCase: getIt(),
      ),
    );

    getIt.registerFactory(
      () => RandomQuestionBloc(
        getRandomQuestionUseCase: getIt(),
      ),
    );

    getIt.registerFactory(
      () => ToggleQuestionLikeCubit(
        toggleQuestionLikeUseCase: getIt(),
      ),
    );

    getIt.registerFactory(
      () => StoredQuestionsFilterCubit(),
    );

    getIt.registerFactory(
      () => StoredQuestionsListBloc(
        getStoredQuestionsUseCase: getIt(),
      ),
    );
  }
}
