import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extension/result_ext.dart';
import '../../../../domain/use_case/get_stored_questions_use_case.dart';
import 'stored_questions_list_bloc_event.dart';
import 'stored_questions_list_bloc_state.dart';

class StoredQuestionsListBloc
    extends Bloc<StoredQuestionsListBlocEvent, StoredQuestionsListBlocState> {
  StoredQuestionsListBloc({
    required this.getStoredQuestionsUseCase,
  }) : super(StoredQuestionsListBlocState.initial()) {
    on<LoadStoredQuestionsListEvent>(
      _loadStoredQuestions,
      transformer: restartable(),
    );
    on<SetFilterEvent>(_setFilter);
  }

  final GetStoredQuestionsUseCase getStoredQuestionsUseCase;
  bool _likedOnly = false;

  Future<void> _loadStoredQuestions(
    LoadStoredQuestionsListEvent event,
    Emitter<StoredQuestionsListBlocState> emit,
  ) async {
    state.maybeWhen(loaded: (questions) {
      emit(StoredQuestionsListBlocState.loading(
        questions: questions,
      ));
    }, orElse: () {
      emit(
        StoredQuestionsListBlocState.loading(),
      );
    });

    await emit.onEach(
      getStoredQuestionsUseCase(
        onlyLiked: _likedOnly,
      ),
      onData: (questions) {
        questions.when(
          value: (value) {
            emit(StoredQuestionsListBlocState.loaded(
              questions: value,
            ));
          },
          error: (error) {
            emit(StoredQuestionsListBlocState.error(
              error: error,
            ));
          },
        );
      },
    );
  }

  Future<void> _setFilter(
    SetFilterEvent event,
    Emitter<StoredQuestionsListBlocState> emit,
  ) async {
    _likedOnly = event.likedOnly;
    add(const LoadStoredQuestionsListEvent());
  }
}
