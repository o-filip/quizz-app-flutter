import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/di/di.dart';
import '../../core/entity/question.dart';
import '../bloc/toggle_question_like/toggle_question_like_cubit.dart';
import '../bloc/toggle_question_like/toggle_question_like_cubit_state.dart';
import '../theme/extensions/colors_extension_theme_data.dart';

class QuestionLikeButton extends StatelessWidget {
  const QuestionLikeButton({
    super.key,
    required this.question,
  });

  final Question question;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ToggleQuestionLikeCubit>(
      create: (_) => getIt<ToggleQuestionLikeCubit>(),
      child: BlocBuilder<ToggleQuestionLikeCubit, ToggleQuestionLikeCubitState>(
        builder: (context, state) {
          return IconButton(
            onPressed: () => _onPressed(context),
            icon: Icon(
              question.isLiked ? Icons.favorite : Icons.favorite_border,
              color: Theme.of(context)
                  .extension<ColorsExtensionThemeData>()!
                  .likeIcon,
            ),
          );
        },
      ),
    );
  }

  void _onPressed(BuildContext context) =>
      context.read<ToggleQuestionLikeCubit>().toggleQuestionLike(question.id);
}
