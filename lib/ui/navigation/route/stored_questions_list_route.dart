import 'package:go_router/go_router.dart';

import '../../screen/stored_questions/stored_questions_list_screen.dart';

class StoredQuestionsListGoRoute {
  static const String path = 'stored-questions';

  static GoRoute generate() {
    return GoRoute(
      path: path,
      builder: (context, state) {
        return const StoredQuestionsListScreen();
      },
    );
  }

  static String route() => '/${Uri(path: path)}';
}
