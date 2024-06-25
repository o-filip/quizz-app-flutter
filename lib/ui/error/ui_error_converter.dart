import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:logging/logging.dart';

import '../../core/error/exception.dart';

class UiErrorConverter {
  static const logTag = 'UiErrorConverter';

  static String convert(
    BuildContext context,
    dynamic error, {
    String? Function(dynamic error)? overrideError,
  }) {
    Logger(logTag).severe('Converting error: $error');
    final errorMessage = overrideError?.call(error);
    if (errorMessage != null) {
      return errorMessage;
    }

    return switch (error) {
      DataException() => _convertDataException(context, error),
      DomainException() => _convertDomainException(context, error),
      _ => S.of(context).error_unknown,
    };
  }

  static String _convertDataException(
    BuildContext context,
    DataException error,
  ) =>
      switch (error) {
        TimeoutDataException() => S.of(context).error_data_timeout,
        UnauthorizedDataException() => S.of(context).error_data_unauthorized,
        CanceledDataException() => S.of(context).error_data_canceled,
        NotFoundDataException() => S.of(context).error_data_not_found,
        UnknownDataException() => S.of(context).error_data_unknown,
        ConnectionErrorDataException() => S.of(context).error_data_connection,
        InvalidOutputFormatDataException() =>
          S.of(context).error_data_invalid_output_format,
        NotEnoughEntriesDataException() =>
          S.of(context).error_data_not_enough_entries
      };

  static String _convertDomainException(
    BuildContext context,
    DomainException error,
  ) =>
      switch (error) {
        QuestionNotFoundDomainException() =>
          S.of(context).error_domain_question_not_found,
        NotEnoughStoredQuestionsDomainException() =>
          S.of(context).error_domain_not_enough_stored_questions,
        NoStoredQuestionDomainException() =>
          S.of(context).error_domain_no_stored_question,
      };
}
