import 'package:flutter/foundation.dart';
import 'package:loggy/loggy.dart';

/// Custom printer that formats logs with timestamp, level, and logger name.
/// Only prints in debug mode to avoid exposing sensitive data in production.
class AppLogPrinter extends LoggyPrinter {
  const AppLogPrinter();

  static const _levelPrefixes = {
    LogLevel.debug: '🐛 DEBUG',
    LogLevel.info: 'ℹ️ INFO',
    LogLevel.warning: '⚠️ WARNING',
    LogLevel.error: '❌ ERROR',
  };

  static const _levelColors = {
    LogLevel.debug: '\x1B[37m', // White
    LogLevel.info: '\x1B[34m', // Blue
    LogLevel.warning: '\x1B[33m', // Yellow
    LogLevel.error: '\x1B[31m', // Red
  };

  static const _resetColor = '\x1B[0m';

  @override
  void onLog(LogRecord record) {
    // Only log in debug mode
    if (!kDebugMode) return;

    final time = record.time.toIso8601String().substring(11, 23);
    final level = _levelPrefixes[record.level] ?? record.level.name;
    final color = _levelColors[record.level] ?? '';
    final loggerName = record.loggerName;

    final message = '$color[$time] $level [$loggerName]: ${record.message}$_resetColor';

    debugPrint(message);

    if (record.error != null) {
      debugPrint('$color  Error: ${record.error}$_resetColor');
    }

    if (record.stackTrace != null) {
      debugPrint('$color  StackTrace: ${record.stackTrace}$_resetColor');
    }
  }
}

/// Initializes the logging system with proper configuration.
void initializeLogging() {
  Loggy.initLoggy(
    logPrinter: const AppLogPrinter(),
    logOptions: const LogOptions(
      // Log everything in debug, only warnings+ in release
      kDebugMode ? LogLevel.all : LogLevel.warning,
      stackTraceLevel: LogLevel.error,
    ),
  );
}
