import 'dart:developer' as developer;

enum LogLevel { debug, info, warning, error }

class Logger {
  static const String _name = 'AppLogger';

  static void debug(String message, {Object? error, StackTrace? stackTrace}) {
    _log(LogLevel.debug, message, error: error, stackTrace: stackTrace);
  }

  static void info(String message, {Object? error, StackTrace? stackTrace}) {
    _log(LogLevel.info, message, error: error, stackTrace: stackTrace);
  }

  static void warning(String message, {Object? error, StackTrace? stackTrace}) {
    _log(LogLevel.warning, message, error: error, stackTrace: stackTrace);
  }

  static void error(String message, {Object? error, StackTrace? stackTrace}) {
    _log(LogLevel.error, message, error: error, stackTrace: stackTrace);
  }

  static void _log(
    LogLevel level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    final timestamp = DateTime.now().toIso8601String();
    final levelString = level.name.toUpperCase();
    final logMessage = '[$timestamp] [$levelString] $message';

    switch (level) {
      case LogLevel.debug:
        developer.log(
          logMessage,
          name: _name,
          level: 500,
          error: error,
          stackTrace: stackTrace,
        );
        break;
      case LogLevel.info:
        developer.log(
          logMessage,
          name: _name,
          level: 800,
          error: error,
          stackTrace: stackTrace,
        );
        break;
      case LogLevel.warning:
        developer.log(
          logMessage,
          name: _name,
          level: 900,
          error: error,
          stackTrace: stackTrace,
        );
        break;
      case LogLevel.error:
        developer.log(
          logMessage,
          name: _name,
          level: 1000,
          error: error,
          stackTrace: stackTrace,
        );
        break;
    }
  }
}

// Extension for easy logging
extension LoggerExtension on Object {
  void logDebug(String message, {Object? error, StackTrace? stackTrace}) {
    Logger.debug(
      '${runtimeType}: $message',
      error: error,
      stackTrace: stackTrace,
    );
  }

  void logInfo(String message, {Object? error, StackTrace? stackTrace}) {
    Logger.info(
      '${runtimeType}: $message',
      error: error,
      stackTrace: stackTrace,
    );
  }

  void logWarning(String message, {Object? error, StackTrace? stackTrace}) {
    Logger.warning(
      '${runtimeType}: $message',
      error: error,
      stackTrace: stackTrace,
    );
  }

  void logError(String message, {Object? error, StackTrace? stackTrace}) {
    Logger.error(
      '${runtimeType}: $message',
      error: error,
      stackTrace: stackTrace,
    );
  }
}
