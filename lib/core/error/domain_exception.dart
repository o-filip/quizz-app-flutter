import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_exception.dart';

part 'domain_exception.freezed.dart';

@freezed
class DomainException with _$DomainException implements BaseException {
  const factory DomainException.notEnoughStoredQuestions() =
      _NotEnoughQuestions;

  const factory DomainException.questionNotFound() = _QuestionNotFound;

  const factory DomainException.noStoredQuestion() = _NoStoredQuestion;
}
