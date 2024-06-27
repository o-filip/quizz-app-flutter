import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/extension/as_ext.dart';
import '../../../core/extension/result_ext.dart';
import '../../../domain/use_case/get_random_question_use_case.dart';
import 'random_question_bloc_event.dart';
import 'random_question_state.dart';

class RandomQuestionBloc
    extends Bloc<RandomQuestionBlocEvent, RandomQuestionState> {
  RandomQuestionBloc({
    required this.getRandomQuestionUseCase,
  }) : super(const RandomQuestionStateInitial()) {
    on<LoadRandomQuestionEvent>(
      _loadRandomQuestion,
      transformer: restartable(),
    );
  }

  final GetRandomQuestionUseCase getRandomQuestionUseCase;

  Future<void> _loadRandomQuestion(
    LoadRandomQuestionEvent event,
    Emitter<RandomQuestionState> emit,
  ) async {
    final currentData = state.asOrNull<RandomQuestionStateData>();

    emit(RandomQuestionStateLoading(question: currentData?.question));

    await emit.onEach(
      getRandomQuestionUseCase(),
      onData: (question) {
        question.when(
          value: (value) {
            emit(RandomQuestionStateData(question: value!));
          },
          error: (error) {
            emit(RandomQuestionStateError(error: error));
          },
        );
      },
    );
  }
}
