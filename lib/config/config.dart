import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static String getAppName() {
    return dotenv.env['APP_NAME'] ?? '';
  }

  static String getAppVersion() {
    return dotenv.env['APP_VERSION'] ?? '';
  }

  static String getServerUrl() {
    if (Platform.isAndroid) {
      return dotenv.env['SERVER_URL_ANDROID'] ?? '';
    }
    return dotenv.env['SERVER_URL'] ?? '';
  }

  static String getGoogleClientId() {
    if (Platform.isAndroid) {
      return dotenv.env['GOOGLE_CLIENT_ID_ANDROID'] ?? '';
    } else if (Platform.isIOS) {
      return dotenv.env['GOOGLE_CLIENT_ID_IOS'] ?? '';
    } else {
      return dotenv.env['GOOGLE_CLIENT_ID_WEB'] ?? '';
    }
  }

  static String getCallbackUrlScheme() {
    if (Platform.isAndroid) {
      return dotenv.env['CALLBACK_URL_SCHEME_ANDROID'] ?? '';
    } else if (Platform.isIOS) {
      return dotenv.env['CALLBACK_URL_SCHEME_IOS'] ?? '';
    } else {
      return dotenv.env['CALLBACK_URL_SCHEME_WEB'] ?? '';
    }
  }
}
