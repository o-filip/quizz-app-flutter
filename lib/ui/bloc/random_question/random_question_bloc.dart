import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/extension/result_ext.dart';
import '../../../domain/use_case/get_random_question_use_case.dart';
import 'random_question_bloc_event.dart';
import 'random_question_bloc_state.dart';

class RandomQuestionBloc
    extends Bloc<RandomQuestionBlocEvent, RandomQuestionBlocState> {
  RandomQuestionBloc({
    required this.getRandomQuestionUseCase,
  }) : super(const RandomQuestionBlocState.initial()) {
    on<LoadRandomQuestionEvent>(
      _loadRandomQuestion,
      transformer: restartable(),
    );
  }

  final GetRandomQuestionUseCase getRandomQuestionUseCase;

  Future<void> _loadRandomQuestion(
    LoadRandomQuestionEvent event,
    Emitter<RandomQuestionBlocState> emit,
  ) async {
    state.maybeWhen(
      loaded: (question) =>
          emit(RandomQuestionBlocState.loading(question: question)),
      orElse: () => emit(const RandomQuestionBlocState.loading()),
    );

    await emit.onEach(
      getRandomQuestionUseCase(),
      onData: (question) {
        question.when(
          value: (value) {
            emit(RandomQuestionBlocState.loaded(value!));
          },
          error: (error) {
            emit(RandomQuestionBlocState.error(error));
          },
        );
      },
    );
  }
}
