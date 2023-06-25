// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    CategoriesSelectionRoute.name: (routeData) {
      final args = routeData.argsAs<CategoriesSelectionRouteArgs>();
      return AutoRoutePage<List<Category>?>(
        routeData: routeData,
        child: CategoriesSelectionScreen(
          key: args.key,
          preselectedCategories: args.preselectedCategories,
        ),
      );
    },
    QuizRoute.name: (routeData) {
      final args = routeData.argsAs<QuizRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: QuizScreen(
          key: args.key,
          difficulty: args.difficulty,
          categories: args.categories,
          numOfQuestions: args.numOfQuestions,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
    StoredQuestionsListRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const StoredQuestionsListScreen(),
      );
    },
  };
}

/// generated route for
/// [CategoriesSelectionScreen]
class CategoriesSelectionRoute
    extends PageRouteInfo<CategoriesSelectionRouteArgs> {
  CategoriesSelectionRoute({
    Key? key,
    required List<Category> preselectedCategories,
    List<PageRouteInfo>? children,
  }) : super(
          CategoriesSelectionRoute.name,
          args: CategoriesSelectionRouteArgs(
            key: key,
            preselectedCategories: preselectedCategories,
          ),
          initialChildren: children,
        );

  static const String name = 'CategoriesSelectionRoute';

  static const PageInfo<CategoriesSelectionRouteArgs> page =
      PageInfo<CategoriesSelectionRouteArgs>(name);
}

class CategoriesSelectionRouteArgs {
  const CategoriesSelectionRouteArgs({
    this.key,
    required this.preselectedCategories,
  });

  final Key? key;

  final List<Category> preselectedCategories;

  @override
  String toString() {
    return 'CategoriesSelectionRouteArgs{key: $key, preselectedCategories: $preselectedCategories}';
  }
}

/// generated route for
/// [QuizScreen]
class QuizRoute extends PageRouteInfo<QuizRouteArgs> {
  QuizRoute({
    Key? key,
    Difficulty? difficulty,
    required List<Category> categories,
    required int numOfQuestions,
    List<PageRouteInfo>? children,
  }) : super(
          QuizRoute.name,
          args: QuizRouteArgs(
            key: key,
            difficulty: difficulty,
            categories: categories,
            numOfQuestions: numOfQuestions,
          ),
          initialChildren: children,
        );

  static const String name = 'QuizRoute';

  static const PageInfo<QuizRouteArgs> page = PageInfo<QuizRouteArgs>(name);
}

class QuizRouteArgs {
  const QuizRouteArgs({
    this.key,
    this.difficulty,
    required this.categories,
    required this.numOfQuestions,
  });

  final Key? key;

  final Difficulty? difficulty;

  final List<Category> categories;

  final int numOfQuestions;

  @override
  String toString() {
    return 'QuizRouteArgs{key: $key, difficulty: $difficulty, categories: $categories, numOfQuestions: $numOfQuestions}';
  }
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [StoredQuestionsListScreen]
class StoredQuestionsListRoute extends PageRouteInfo<void> {
  const StoredQuestionsListRoute({List<PageRouteInfo>? children})
      : super(
          StoredQuestionsListRoute.name,
          initialChildren: children,
        );

  static const String name = 'StoredQuestionsListRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
