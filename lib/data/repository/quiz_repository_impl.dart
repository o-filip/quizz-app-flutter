import 'package:async/async.dart';

import '../../core/entity/question.dart';
import '../../core/enum/category.dart';
import '../../core/enum/difficulty.dart';
import '../../core/error/data_exception.dart';
import '../../core/network/connectivity_info.dart';
import '../converter/question_model_converter.dart';
import '../local/data_store/questions_local_data_store.dart';
import '../remote/data_store/quiz_remote_data_store.dart';
import 'base_repository.dart';
import 'quiz_repository.dart';

class QuizRepositoryImpl extends QuizRepository with BaseRepository {
  QuizRepositoryImpl({
    required this.remoteDataStore,
    required this.localDataStore,
    required this.questionsConverter,
    required this.connectivityInfo,
  });

  final QuizRemoteDataStore remoteDataStore;
  final QuestionsLocalDataStore localDataStore;
  final QuestionModelConverter questionsConverter;
  final ConnectivityInfo connectivityInfo;

  @override
  Stream<Result<List<Question>>> getQuiz({
    List<Category>? categories,
    Difficulty? difficulty,
    required int minimalNumOfQuestions,
  }) async* {
    if (await connectivityInfo.isConnected) {
      yield* _getQuizFromRemote(
        categories: categories,
        difficulty: difficulty,
        minimalNumOfQuestions: minimalNumOfQuestions,
      );
    } else {
      yield* _getQuizFromLocal(
        categories: categories,
        difficulty: difficulty,
        minimalNumOfQuestions: minimalNumOfQuestions,
      );
    }
  }

  Stream<Result<List<Question>>> _getQuizFromRemote({
    List<Category>? categories,
    Difficulty? difficulty,
    required int minimalNumOfQuestions,
  }) =>
      fetchFutureStream(() async {
        final response = await remoteDataStore.getQuiz(
          limit: minimalNumOfQuestions,
          categories: categories,
          difficulty: difficulty,
        );

        // Save to local
        final localModel = questionsConverter.remoteToLocalModelList(response);
        await localDataStore.createOrUpdateQuestions(localModel);

        // Return stream from local
        return localDataStore
            .getQuestionsByIds(
              questionIds: response.map((e) => e.id),
            )
            .map((questions) => questionsConverter.localToEntityList(questions))
            .map((event) => Result.value(event));
      });

  Stream<Result<List<Question>>> _getQuizFromLocal({
    List<Category>? categories,
    Difficulty? difficulty,
    required int minimalNumOfQuestions,
  }) =>
      fetchStream(() async* {
        yield* localDataStore
            .getQuestions(
          categories: categories,
          difficulty: difficulty,
        )
            .map(
          (questions) {
            if (questions.length < minimalNumOfQuestions) {
              return Result.error(const DataException.notEnoughEntries());
            } else {
              return Result.value(
                questionsConverter.localToEntityList(questions),
              );
            }
          },
        );
      });

  @override
  Stream<Result<List<Question>>> getStoredQuestions({
    List<Category>? categories,
    Difficulty? difficulty,
    bool onlyLiked = false,
  }) =>
      fetchStream(() => localDataStore
          .getQuestions(
            categories: categories,
            difficulty: difficulty,
            likedOnly: onlyLiked,
          )
          .map((data) => questionsConverter.localToEntityList(data))
          .map((data) => Result.value(data)));

  @override
  Future<Result<void>> updateQuestion(Question question) async =>
      doEmptyResult(() => localDataStore.createOrUpdateQuestion(
            questionsConverter.entityToLocalModel(question),
          ));

  @override
  Stream<Result<Question?>> getQuestionById({
    required String id,
  }) =>
      fetchStream(
        () => localDataStore
            .getQuestionById(questionId: id)
            .map((data) =>
                data != null ? questionsConverter.localToEntity(data) : null)
            .map((data) => Result.value(data)),
      );
}
