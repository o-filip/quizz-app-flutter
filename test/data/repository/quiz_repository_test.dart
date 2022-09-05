import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quiz_app/core/entity/question.dart';
import 'package:quiz_app/core/enum/category.dart';
import 'package:quiz_app/core/enum/difficulty.dart';
import 'package:quiz_app/core/error/data_exception.dart';
import 'package:quiz_app/core/network/connectivity_info.dart';
import 'package:quiz_app/data/remote/data_store/quiz_remote_data_store.dart';
import 'package:quiz_app/data/repository/quiz_repository_impl.dart';

import '../../fixtures/fixtures.dart';
import '../../mock/mock_questions_converter.dart';
import '../../mock/mock_questions_local_data_store.dart';
import 'quiz_repository_test.mocks.dart';

@GenerateMocks([
  ConnectivityInfo,
  Question,
  QuizRemoteDataStore,
])
void main() {
  late QuizRepositoryImpl repository;
  late MockQuizRemoteDataStore mockRemoteDataStore;
  late MockQuestionsLocalDataStore mockQuestionsLocalDataStore;
  late MockQuestionsConverter mockQuestionsConverter;
  late MockConnectivityInfo mockConnectivityInfo;

  setUp(() {
    mockRemoteDataStore = MockQuizRemoteDataStore();
    mockQuestionsLocalDataStore = MockQuestionsLocalDataStore();
    mockQuestionsConverter = MockQuestionsConverter();
    mockConnectivityInfo = MockConnectivityInfo();
    repository = QuizRepositoryImpl(
      remoteDataStore: mockRemoteDataStore,
      localDataStore: mockQuestionsLocalDataStore,
      questionsConverter: mockQuestionsConverter,
      connectivityInfo: mockConnectivityInfo,
    );
  });

  group('QuizRepositoryImpl', () {
    group('getQuiz', () {
      final categories = [Category.generalKnowledge];
      const minimalNumOfQuestions = 5;
      const difficulty = Difficulty.easy;
      final remoteQuestions = generateQuestionRemoteModelFixtures(
        questionCnt: minimalNumOfQuestions,
      );
      final localQuestions = generateQuestionLocalModelFixtures(
        questionCnt: minimalNumOfQuestions,
      );
      final questions = generateQuestionFixtures(
        questionCnt: minimalNumOfQuestions,
      );

      test('''
        emits list of questions when device is 
        offline and there is enough of cached questions''', () async {
        when(mockQuestionsLocalDataStore.getQuestions(
          categories: anyNamed('categories'),
          difficulty: anyNamed('difficulty'),
          likedOnly: anyNamed('likedOnly'),
        )).thenAnswer((_) => Stream.value(localQuestions));

        when(mockQuestionsConverter.localToEntityList(any))
            .thenReturn(questions);

        when(mockConnectivityInfo.isConnected).thenAnswer((_) async => false);

        final result = await repository
            .getQuiz(
              categories: categories,
              difficulty: difficulty,
              minimalNumOfQuestions: 5,
            )
            .toList();

        expect(result.isEmpty, isFalse);
        expect(result.first.isValue, isTrue);
        expect(
          result.first.asValue?.value,
          hasLength(greaterThanOrEqualTo(minimalNumOfQuestions)),
        );
        verify(mockConnectivityInfo.isConnected);
        verify(mockQuestionsLocalDataStore.getQuestions(
          categories: categories,
          difficulty: difficulty,
        ));
        verify(mockQuestionsConverter.localToEntityList(localQuestions));
        verifyNoMoreInteractions(mockRemoteDataStore);
        verifyNoMoreInteractions(mockQuestionsLocalDataStore);
        verifyNoMoreInteractions(mockQuestionsConverter);
      });

      test('''
        throws error when device is 
        offline and there is NOT enough of cached questions''', () async {
        // arrange
        final localQuestions = generateQuestionLocalModelFixtures(
          questionCnt: 1,
        );

        when(mockQuestionsLocalDataStore.getQuestions(
          categories: anyNamed('categories'),
          difficulty: anyNamed('difficulty'),
          likedOnly: anyNamed('likedOnly'),
        )).thenAnswer((_) => Stream.value(localQuestions));

        when(mockConnectivityInfo.isConnected).thenAnswer((_) async => false);

        // act
        final result = await repository
            .getQuiz(
              categories: categories,
              difficulty: difficulty,
              minimalNumOfQuestions: 5,
            )
            .toList();

        // assert
        expect(result.first.isError, isTrue);
        expect(result.first.asError?.error, isA<DataException>());
        verify(mockConnectivityInfo.isConnected);
        verify(mockQuestionsLocalDataStore.getQuestions(
          categories: categories,
          difficulty: difficulty,
        ));
        verifyNoMoreInteractions(mockRemoteDataStore);
        verifyNoMoreInteractions(mockQuestionsLocalDataStore);
      });

      test('''
        when device is online should download, store questions 
        and return a stream with a list of questions 
        longer than minimalNumOfQuestions ''', () async {
        // Arrange
        when(mockConnectivityInfo.isConnected).thenAnswer((_) async => true);

        when(mockRemoteDataStore.getQuiz(
          limit: anyNamed('limit'),
          categories: anyNamed('categories'),
          difficulty: anyNamed('difficulty'),
          region: anyNamed('region'),
        )).thenAnswer((_) async => remoteQuestions);

        when(mockQuestionsConverter.remoteToLocalModelList(any))
            .thenReturn(localQuestions);

        when(mockQuestionsLocalDataStore.getQuestionsByIds(
          questionIds: anyNamed('questionIds'),
        )).thenAnswer((_) => Stream.value(localQuestions));

        when(mockQuestionsLocalDataStore.createOrUpdateQuestions(any))
            .thenAnswer((_) => Future.value());

        when(mockQuestionsConverter.localToEntityList(any))
            .thenReturn(questions);

        // Act
        final result = await repository
            .getQuiz(
              categories: categories,
              difficulty: difficulty,
              minimalNumOfQuestions: minimalNumOfQuestions,
            )
            .toList();

        // Assert
        expect(result.isEmpty, isFalse);
        expect(result.first.isValue, isTrue);
        final value = result.first.asValue?.value;
        expect(
          value?.length,
          greaterThanOrEqualTo(minimalNumOfQuestions),
        );
        expect(value, questions);
        verify(mockRemoteDataStore.getQuiz(
          limit: minimalNumOfQuestions,
          categories: categories,
          difficulty: difficulty,
        ));
        verify(mockQuestionsConverter.remoteToLocalModelList(remoteQuestions));
        verify(mockQuestionsConverter.localToEntityList(localQuestions));
        verify(mockQuestionsLocalDataStore
            .createOrUpdateQuestions(localQuestions));
        verify(mockQuestionsLocalDataStore.getQuestionsByIds(
          questionIds: questions.map((e) => e.id).toList(),
        ));
        verifyNoMoreInteractions(mockRemoteDataStore);
        verifyNoMoreInteractions(mockQuestionsConverter);
        verifyNoMoreInteractions(mockQuestionsLocalDataStore);
      });

      test('should update the question in the local database', () async {
        // arrange
        final localQuestion =
            generateQuestionLocalModelFixtures(questionCnt: 1).first;
        final question = generateQuestionFixtures(questionCnt: 1).first;
        when(mockQuestionsConverter.entityToLocalModel(question))
            .thenReturn(localQuestion);
        when(mockQuestionsLocalDataStore.createOrUpdateQuestion(any))
            .thenAnswer((_) => Future.value());

        // act
        final result = await repository.updateQuestion(question);

        expect(
            mockQuestionsConverter.entityToLocalModel(question), localQuestion);

        // assert
        expect(result.isValue, isTrue);
        verify(mockQuestionsConverter.entityToLocalModel(any));
        verify(
            mockQuestionsLocalDataStore.createOrUpdateQuestion(localQuestion));
        verifyNoMoreInteractions(mockQuestionsConverter);
        verifyNoMoreInteractions(mockQuestionsLocalDataStore);
      });
    });
  });
}
