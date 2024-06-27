import 'package:async/async.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quiz_app/domain/use_case/get_random_question_use_case.dart';
import 'package:quiz_app/ui/bloc/random_question/random_question_bloc.dart';
import 'package:quiz_app/ui/bloc/random_question/random_question_bloc_event.dart';
import 'package:quiz_app/ui/bloc/random_question/random_question_state.dart';

import '../../fixtures/fixtures.dart';
import 'random_question_bloc_test.mocks.dart';

@GenerateMocks([
  GetRandomQuestionUseCase,
])
void main() {
  group('RandomQuestionBloc', () {
    late RandomQuestionBloc randomQuestionBloc;
    late MockGetRandomQuestionUseCase mockGetRandomQuestionUseCase;

    setUp(() {
      mockGetRandomQuestionUseCase = MockGetRandomQuestionUseCase();

      randomQuestionBloc = RandomQuestionBloc(
        getRandomQuestionUseCase: mockGetRandomQuestionUseCase,
      );
    });

    tearDown(() {
      randomQuestionBloc.close();
    });

    test('initial state is correct', () {
      expect(randomQuestionBloc.state, const RandomQuestionStateInitial());
    });

    test(
      'emits loading and loaded states when loading questions',
      () async {
        final question = generateQuestionFixtures(questionCnt: 1).first;
        when(mockGetRandomQuestionUseCase())
            .thenAnswer((_) => Stream.value(Result.value(question)));

        const event = LoadRandomQuestionEvent();

        final expectedStates = [
          RandomQuestionStateLoading(),
          RandomQuestionStateData(question: question),
        ];

        await testBloc(
          build: () => randomQuestionBloc,
          act: (bloc) => bloc.add(event),
          expect: () => expectedStates,
          verify: (_) {
            verify(mockGetRandomQuestionUseCase());
            verifyNoMoreInteractions(mockGetRandomQuestionUseCase);
          },
        );
      },
    );

    test('emits error state when an error occurs', () async {
      final error = Exception('An error occurred');
      when(mockGetRandomQuestionUseCase())
          .thenAnswer((_) => Stream.value(Result.error(error)));

      const event = LoadRandomQuestionEvent();
      final expectedStates = [
        RandomQuestionStateLoading(),
        RandomQuestionStateError(error: error),
      ];

      await testBloc(
        build: () => randomQuestionBloc,
        act: (bloc) => bloc.add(event),
        expect: () => expectedStates,
        verify: (_) {
          verify(mockGetRandomQuestionUseCase());
          verifyNoMoreInteractions(mockGetRandomQuestionUseCase);
        },
      );
    });
  });
}
