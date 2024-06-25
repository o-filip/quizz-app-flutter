import 'package:async/async.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quiz_app/domain/use_case/get_stored_questions_use_case.dart';
import 'package:quiz_app/ui/bloc/stored_questions/list/stored_questions_list_bloc.dart';
import 'package:quiz_app/ui/bloc/stored_questions/list/stored_questions_list_bloc_event.dart';
import 'package:quiz_app/ui/bloc/stored_questions/list/stored_questions_list_state.dart';

import '../../fixtures/fixtures.dart';
import 'stored_questions_list_bloc_test.mocks.dart';

@GenerateMocks([GetStoredQuestionsUseCase])
void main() {
  late StoredQuestionsListBloc storedQuestionsListBloc;
  late MockGetStoredQuestionsUseCase mockGetStoredQuestionsUseCase;

  final questions = generateQuestionFixtures(questionCnt: 2);

  setUp(() {
    mockGetStoredQuestionsUseCase = MockGetStoredQuestionsUseCase();
    storedQuestionsListBloc = StoredQuestionsListBloc(
      getStoredQuestionsUseCase: mockGetStoredQuestionsUseCase,
    );
  });

  tearDown(() {
    storedQuestionsListBloc.close();
  });

  group('StoredQuestionListBloc', () {
    test(
        'emits loading and loaded state when getStoredQuestionsUseCase returns value',
        () async {
      when(mockGetStoredQuestionsUseCase())
          .thenAnswer((_) => Stream.value(Result.value(questions)));

      const event = LoadStoredQuestionsListEvent();

      final expectedStates = [
        StoredQuestionsListStateLoading(),
        StoredQuestionsListStateData(questions: questions)
      ];

      await testBloc(
        build: () => storedQuestionsListBloc,
        act: (bloc) => bloc.add(event),
        expect: () => expectedStates,
        verify: (_) {
          verify(mockGetStoredQuestionsUseCase());
          verifyNoMoreInteractions(mockGetStoredQuestionsUseCase);
        },
      );
    });

    test('emits error state when getStoredQuestionsUseCase returns error',
        () async {
      final error = Exception('Failed to load questions');

      when(mockGetStoredQuestionsUseCase())
          .thenAnswer((_) => Stream.value(Result.error(error)));

      const event = LoadStoredQuestionsListEvent();

      final expectedStates = [
        StoredQuestionsListStateLoading(),
        StoredQuestionsListStateError(error: error)
      ];

      await testBloc(
        build: () => storedQuestionsListBloc,
        act: (bloc) => bloc.add(event),
        expect: () => expectedStates,
        verify: (_) {
          verify(mockGetStoredQuestionsUseCase());
          verifyNoMoreInteractions(mockGetStoredQuestionsUseCase);
        },
      );
    });
  });
}
