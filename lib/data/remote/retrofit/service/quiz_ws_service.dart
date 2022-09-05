import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../model/question_remote_model.dart';

part 'quiz_ws_service.g.dart';

@RestApi()
abstract class QuizWsService {
  factory QuizWsService(
    Dio dio, {
    required String baseUrl,
  }) = _QuizWsService;

  @GET('/questions')
  Future<List<QuestionRemoteModel>> getQuiz({
    @Query('categories') String? categories,
    @Query('limit') required int limit,
    @Query('region') required String region,
    @Query('difficulty') String? difficulty,
  });
}
