import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/di/di.dart';
import 'core/logging/logging.dart';
import 'ui/bloc/random_question/random_question_bloc.dart';
import 'ui/bloc/random_question/random_question_bloc_event.dart';
import 'ui/bloc/stored_questions/filter/stored_questions_filter_cubit.dart';
import 'ui/bloc/stored_questions/filter/stored_questions_filter_state.dart';
import 'ui/bloc/stored_questions/list/stored_questions_list_bloc.dart';
import 'ui/bloc/stored_questions/list/stored_questions_list_bloc_event.dart';
import 'ui/theme/quiz_app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await getIt.allReady();
  getIt<Logging>().setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<StoredQuestionsListBloc>(
          create: (_) => getIt<StoredQuestionsListBloc>()
            ..add(const LoadStoredQuestionsListEvent()),
        ),
        BlocProvider<StoredQuestionsFilterCubit>(
          create: (_) => getIt(),
        ),
        BlocProvider<RandomQuestionBloc>(
          create: (_) =>
              getIt<RandomQuestionBloc>()..add(const LoadRandomQuestionEvent()),
        ),
      ],
      child:
          BlocListener<StoredQuestionsFilterCubit, StoredQuestionsFilterState>(
        listener: (context, state) {
          context.read<StoredQuestionsListBloc>().add(
                SetFilterEvent(
                  likedOnly: state.likedOnly,
                ),
              );
        },
        child: MaterialApp.router(
          title: 'Flutter Demo',
          theme: QuizAppTheme.createTheme(),
          routerConfig: getIt(),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        ),
      ),
    );
  }
}
