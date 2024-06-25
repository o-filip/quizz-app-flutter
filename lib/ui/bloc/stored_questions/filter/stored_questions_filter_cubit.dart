import 'package:flutter_bloc/flutter_bloc.dart';

import 'stored_questions_filter_state.dart';

class StoredQuestionsFilterCubit extends Cubit<StoredQuestionsFilterState> {
  StoredQuestionsFilterCubit() : super(StoredQuestionsFilterState());

  void toggleLikedOnly() {
    emit(state.copyWith(likedOnly: !state.likedOnly));
  }
}
