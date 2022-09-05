import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

abstract class Logging {
  void setup() {}
}

class LoggingImpl extends Logging {
  @override
  void setup() {
    // Just a simple logger that prints everything to the console.
    // Later we can use a more sophisticated logger like sentry or firebase.
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      if (kDebugMode) {
        print(_formatConsoleMessage(record));
      }
    });
  }

  String _formatConsoleMessage(LogRecord record) {
    final color = _getConsoleColor(record.level);
    final colorName = color != null ? '\x1B[${color}m' : '';
    final colorReset = color != null ? '\x1B[0m' : '';
    final error = record.error != null ? ' ${record.error}' : '';
    final stackTrace =
        record.stackTrace != null ? '\n${record.stackTrace}' : '';
    return '$colorName${record.loggerName} - ${record.level.name}: ${record.message}$error$stackTrace$colorReset';
  }

  int? _getConsoleColor(Level level) {
    if (level == Level.SEVERE || level == Level.SHOUT) {
      return 31; // RED
    } else if (level == Level.WARNING) {
      return 33; // YELLOW
    } else if (level == Level.INFO) {
      return 36; // CYAN
    } else if (level == Level.FINE) {
      return 90; // GREY
    } else {
      return null;
    }
  }
}
