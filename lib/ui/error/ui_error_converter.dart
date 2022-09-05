import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../core/error/data_exception.dart';
import '../../core/error/domain_exception.dart';
import '../../localization/l10n.dart';

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

    if (error is DataException) {
      return _convertDataException(context, error);
    } else if (error is DomainException) {
      return _convertDomainException(context, error);
    } else {
      return S.of(context).error_unknown;
    }
  }

  static String _convertDataException(
    BuildContext context,
    DataException error,
  ) =>
      error.map(
        timeout: (_) => S.of(context).error_data_timeout,
        canceled: (_) => S.of(context).error_data_canceled,
        connectionError: (_) => S.of(context).error_data_connection,
        invalidOutputFormat: (_) =>
            S.of(context).error_data_invalid_output_format,
        notEnoughEntries: (_) => S.of(context).error_data_not_enough_entries,
        notFound: (_) => S.of(context).error_data_not_found,
        unauthorized: (_) => S.of(context).error_data_unauthorized,
        unknown: (_) => S.of(context).error_data_unknown,
      );

  static String _convertDomainException(
    BuildContext context,
    DomainException error,
  ) =>
      error.map(
        questionNotFound: (_) => S.of(context).error_domain_question_not_found,
        notEnoughStoredQuestions: (_) =>
            S.of(context).error_domain_not_enough_stored_questions,
        noStoredQuestion: (_) => S.of(context).error_domain_no_stored_question,
      );
}
