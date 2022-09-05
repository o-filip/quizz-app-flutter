import 'package:async/async.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quiz_app/domain/use_case/toggle_question_like_use_case.dart';
import 'package:quiz_app/ui/bloc/toggle_question_like/toggle_question_like_cubit.dart';
import 'package:quiz_app/ui/bloc/toggle_question_like/toggle_question_like_cubit_state.dart';

import '../../fixtures/fixtures.dart';
import 'toggle_question_like_cubit_test.mocks.dart';

@GenerateMocks([ToggleQuestionLikeUseCase])
void main() {
  late ToggleQuestionLikeCubit toggleQuestionLikeCubit;
  late MockToggleQuestionLikeUseCase mockToggleQuestionLikeUseCase;

  final question = generateQuestionFixtures(questionCnt: 1).first;

  setUp(() {
    mockToggleQuestionLikeUseCase = MockToggleQuestionLikeUseCase();
    toggleQuestionLikeCubit = ToggleQuestionLikeCubit(
      toggleQuestionLikeUseCase: mockToggleQuestionLikeUseCase,
    );
  });

  tearDown(() {
    toggleQuestionLikeCubit.close();
  });

  group('ToggleQuestionLikeCubit', () {
    test('emits done state when toggleQuestionLikeUseCase returns value',
        () async {
      when(mockToggleQuestionLikeUseCase(any)).thenAnswer(
        (_) => Future.value(Result.value(null)),
      );

      final expectedStates = [
        const ToggleQuestionLikeCubitState.toggleInProgress(),
        const ToggleQuestionLikeCubitState.done()
      ];

      await testBloc(
        build: () => toggleQuestionLikeCubit,
        act: (cubit) => cubit.toggleQuestionLike(question.id),
        expect: () => expectedStates,
        verify: (_) {
          verify(mockToggleQuestionLikeUseCase(question.id));
          verifyNoMoreInteractions(mockToggleQuestionLikeUseCase);
        },
      );
    });

    test('emits error state when toggleQuestionLikeUseCase returns error',
        () async {
      final error = Exception('Failed to toggle like');

      when(mockToggleQuestionLikeUseCase(question.id)).thenAnswer(
        (_) => Future.value(Result.error(error)),
      );

      final expectedStates = [
        const ToggleQuestionLikeCubitState.toggleInProgress(),
        ToggleQuestionLikeCubitState.error(error)
      ];

      await testBloc(
        build: () => toggleQuestionLikeCubit,
        act: (cubit) => cubit.toggleQuestionLike(question.id),
        expect: () => expectedStates,
        verify: (_) {
          verify(mockToggleQuestionLikeUseCase(question.id));
          verifyNoMoreInteractions(mockToggleQuestionLikeUseCase);
        },
      );
    });
  });
}
