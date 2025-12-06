import 'package:flutter/foundation.dart';

/// Lightweight logger helper that only prints in debug builds.
class LoggerHelper {
  LoggerHelper._();

  static void log(String message) {
    if (kDebugMode) debugPrint(message);
  }

  static void error(String message) {
    if (kDebugMode) debugPrint('ERROR: $message');
  }
}
