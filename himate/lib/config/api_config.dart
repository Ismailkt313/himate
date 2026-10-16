import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';

class ApiConfig {
  /// Production Base URL deployed on Render
  static const String prodUrl = 'https://himate-nteg.onrender.com/api';

  /// Local Development Base URL
  /// - Android Emulator: 10.0.2.2 (alias to host PC's localhost)
  /// - Web / iOS Simulator / Desktop: localhost
  static String get devUrl {
    if (kIsWeb) {
      return 'http://localhost:5001/api';
    }
    try {
      if (Platform.isAndroid) {
        return 'http://10.0.2.2:5001/api';
      }
    } catch (_) {}
    return 'http://localhost:5001/api';
  }

  /// Set this to `true` if you want to test the production server
  /// while still running in debug mode.
  static const bool forceProduction = false;

  /// Returns the active Base URL:
  /// 1. Command-line override via `--dart-define=BASE_URL=...` (if passed)
  /// 2. If [forceProduction] is true -> [prodUrl]
  /// 3. In Release mode (`flutter build apk/ipa`) -> [prodUrl]
  /// 4. In Debug mode (`flutter run`) -> [devUrl]
  static String get baseUrl {
    const customUrl = String.fromEnvironment('BASE_URL');
    if (customUrl.isNotEmpty) {
      return customUrl;
    }

    if (forceProduction) {
      return prodUrl;
    }

    return kReleaseMode ? prodUrl : devUrl;
  }
}
