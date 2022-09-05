import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../logging/logging.dart';
import '../../network/connectivity_info.dart';
import '../../util/answers_permutation_utils.dart';
import '../di.dart';

class CoreDiModule {
  static void register() {
    _registerNetwork();
    _registerUtils();
    _registerLogging();
  }

  static void _registerNetwork() {
    getIt.registerFactory(
      () => InternetConnectionChecker(),
    );

    getIt.registerSingleton<ConnectivityInfo>(
      ConnectivityInfoImpl(connectionChecker: getIt()),
    );
  }

  static void _registerUtils() {
    getIt.registerFactory<AnswersPermutationUtils>(
      () => AnswersPermutationUtilsImpl(),
    );
  }

  static void _registerLogging() {
    getIt.registerFactory<Logging>(
      () => LoggingImpl(),
    );
  }
}
