import 'package:go_router/go_router.dart';

import '../../screen/home/home_screen.dart';

class HomeGoRoute {
  static const String path = '/';

  static GoRoute generate(List<GoRoute> routes) => GoRoute(
        path: path,
        builder: (context, state) => const HomeScreen(),
        routes: routes,
      );

  static String route() => path;
}
