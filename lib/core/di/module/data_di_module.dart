import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../data/converter/question_model_converter.dart';
import '../../../data/local/data_store/questions_local_data_store.dart';
import '../../../data/local/data_store/questions_local_data_store_drift.dart';
import '../../../data/local/drift/dao/questions_dao.dart';
import '../../../data/local/drift/dao/questions_dao_impl.dart';
import '../../../data/local/drift/database/database.dart';
import '../../../data/remote/data_store/quiz_remote_data_store.dart';
import '../../../data/remote/data_store/quiz_remote_data_store_retrofit.dart';
import '../../../data/remote/retrofit/service/quiz_ws_service.dart';
import '../../../data/repository/quiz_repository.dart';
import '../../../data/repository/quiz_repository_impl.dart';
import '../di.dart';
import '../di_name.dart';

class DataDiModule {
  static void register() {
    _registerModelConvertors();

    _registerDatabase();
    _registerDaos();
    _registerLocalDataStores();

    _registerRemoteDataStoreConstants();
    _registerDioInterceptors();
    _registerDio();
    _registerWebServices();
    _registerRemoteDataStores();

    _registerRepositories();
  }

  static void _registerModelConvertors() {
    getIt.registerFactory<QuestionModelConverter>(
      () => QuestionModelConverterImpl(),
    );
  }

  QuizWsService get quizRemoteDataStore => QuizWsService(
        getIt<Dio>(),
        baseUrl: getIt<String>(instanceName: DiName.baseUrl),
      );

  static void _registerDatabase() {
    getIt.registerSingleton<AppDatabase>(AppDatabase());
  }

  static void _registerDaos() {
    getIt.registerFactory<QuestionsDao>(
        () => QuestionsDaoImpl(getIt<AppDatabase>()));
  }

  static void _registerLocalDataStores() {
    getIt.registerFactory<QuestionsLocalDataStore>(
        () => QuestionsLocalDataStoreDrift(
              questionsDao: getIt<QuestionsDao>(),
              questionsConverter: getIt<QuestionModelConverter>(),
            ));
  }

  static void _registerRemoteDataStoreConstants() {
    getIt.registerSingleton<String>(
      'https://the-trivia-api.com/api/',
      instanceName: DiName.baseUrl,
    );
  }

  static void _registerDioInterceptors() {
    getIt.registerFactory(() => PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          maxWidth: 120,
        ));
  }

  static void _registerDio() {
    getIt.registerFactory(() {
      final dio = Dio();

      dio.options.headers['Accept'] = 'application/json';

      dio.interceptors.add(getIt<PrettyDioLogger>());

      return dio;
    });
  }

  static void _registerWebServices() {
    getIt.registerFactory(
      () => QuizWsService(
        getIt<Dio>(),
        baseUrl: getIt<String>(instanceName: DiName.baseUrl),
      ),
    );
  }

  static void _registerRemoteDataStores() {
    getIt.registerFactory<QuizRemoteDataStore>(() => QuizRemoteDataStoreImpl(
          quizWsService: getIt(),
        ));
  }

  static void _registerRepositories() {
    getIt.registerFactory<QuizRepository>(() => QuizRepositoryImpl(
          connectivityInfo: getIt(),
          localDataStore: getIt(),
          questionsConverter: getIt(),
          remoteDataStore: getIt(),
        ));
  }
}
