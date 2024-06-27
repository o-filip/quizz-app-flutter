sealed class BaseException implements Exception {
  const BaseException();
}

///////////////////////////////////////////////////////////////////////////////
// DataException

sealed class DataException implements BaseException {
  const DataException();
}

class TimeoutDataException extends DataException {
  const TimeoutDataException({
    this.cause,
  });

  final dynamic cause;
}

class UnauthorizedDataException extends DataException {
  const UnauthorizedDataException({
    this.cause,
  });

  final dynamic cause;
}

class CanceledDataException extends DataException {
  const CanceledDataException({
    this.cause,
  });

  final dynamic cause;
}

class NotFoundDataException extends DataException {
  const NotFoundDataException({
    this.cause,
  });

  final dynamic cause;
}

class UnknownDataException extends DataException {
  const UnknownDataException({
    this.cause,
  });

  final dynamic cause;
}

class ConnectionErrorDataException extends DataException {
  const ConnectionErrorDataException({
    this.cause,
  });

  final dynamic cause;
}

class InvalidOutputFormatDataException extends DataException {
  const InvalidOutputFormatDataException({
    this.cause,
  });

  final dynamic cause;
}

class NotEnoughEntriesDataException extends DataException {
  const NotEnoughEntriesDataException({
    this.cause,
  });

  final dynamic cause;
}

///////////////////////////////////////////////////////////////////////////////
// DomainException

sealed class DomainException implements BaseException {
  const DomainException();
}

class NotEnoughStoredQuestionsDomainException extends DomainException {
  const NotEnoughStoredQuestionsDomainException();
}

class QuestionNotFoundDomainException extends DomainException {
  const QuestionNotFoundDomainException();
}

class NoStoredQuestionDomainException extends DomainException {
  const NoStoredQuestionDomainException();
}
