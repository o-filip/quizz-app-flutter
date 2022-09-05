import 'package:flutter_bloc/flutter_bloc.dart';

import 'stored_questions_filter_cubit_state.dart';

class StoredQuestionsFilterCubit
    extends Cubit<StoredQuestionsFilterCubitState> {
  StoredQuestionsFilterCubit() : super(StoredQuestionsFilterCubitState());

  void toggleLikedOnly() {
    emit(state.copyWith(likedOnly: !state.likedOnly));
  }
}
