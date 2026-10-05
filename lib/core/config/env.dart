import 'package:flutter/foundation.dart';

class Env {
  static const String _localApiUrl = 'http://localhost:3000/api';
  static const String _localAndroidUrl = 'http://10.0.2.2:3000/api';
  static const String _prodApiUrl = 'https://animebackendbot.vercel.app/';

  static const String _environment =
      String.fromEnvironment('ENV', defaultValue: 'local');

  static bool get isProduction => _environment == 'prod';

  static String get apiBaseUrl {
    if (isProduction) return _prodApiUrl;
    if (defaultTargetPlatform == TargetPlatform.android) {
      return _localAndroidUrl;
    }
    return _localApiUrl;
  }
}