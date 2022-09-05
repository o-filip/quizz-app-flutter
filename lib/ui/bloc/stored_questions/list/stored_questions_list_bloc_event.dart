abstract class StoredQuestionsListBlocEvent {
  const StoredQuestionsListBlocEvent();
}

class LoadStoredQuestionsListEvent extends StoredQuestionsListBlocEvent {
  const LoadStoredQuestionsListEvent();
}

class SetFilterEvent extends StoredQuestionsListBlocEvent {
  const SetFilterEvent({
    this.likedOnly = false,
  });

  final bool likedOnly;
}
