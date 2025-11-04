import 'package:flutter/foundation.dart';

class AppConfig {

  static const String baseUrl = _isProduction
      ? 'https://api.github.com/'
      : 'https://api.github.com/';

  static const String appVersion = '1.0.0';
  static const bool _isProduction = kReleaseMode;

  static const bool enableLogging = !kReleaseMode;
  static const bool enableMockData = false;

  /// Timeout durations
  static const Duration apiTimeout = Duration(seconds: 30);

  static const String appName = 'Github Explorer';

  static String get environment => _isProduction ? 'Production' : 'Development';
}