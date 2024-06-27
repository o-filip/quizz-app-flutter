import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extension/as_ext.dart';
import '../../../../core/extension/result_ext.dart';
import '../../../../domain/use_case/get_stored_questions_use_case.dart';
import 'stored_questions_list_bloc_event.dart';
import 'stored_questions_list_state.dart';

class StoredQuestionsListBloc
    extends Bloc<StoredQuestionsListBlocEvent, StoredQuestionsListState> {
  StoredQuestionsListBloc({
    required this.getStoredQuestionsUseCase,
  }) : super(const StoredQuestionsListStateInitial()) {
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
    Emitter<StoredQuestionsListState> emit,
  ) async {
    final currentData = state.asOrNull<StoredQuestionsListStateData>();

    emit(StoredQuestionsListStateLoading(
      questions: currentData?.questions,
    ));

    await emit.onEach(
      getStoredQuestionsUseCase(
        onlyLiked: _likedOnly,
      ),
      onData: (questions) {
        questions.when(
          value: (value) {
            emit(StoredQuestionsListStateData(
              questions: value,
            ));
          },
          error: (error) {
            emit(StoredQuestionsListStateError(
              error: error,
            ));
          },
        );
      },
    );
  }

  Future<void> _setFilter(
    SetFilterEvent event,
    Emitter<StoredQuestionsListState> emit,
  ) async {
    _likedOnly = event.likedOnly;
    add(const LoadStoredQuestionsListEvent());
  }
}
