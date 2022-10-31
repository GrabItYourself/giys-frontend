import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:giys_frontend/config/config.dart';
import 'package:http/http.dart' as http;

class AuthService {
  AuthService();

  Future<void> authenticate(BuildContext context) async {
    final url = Uri.https('accounts.google.com', '/o/oauth2/v2/auth', {
      'response_type': 'code',
      'client_id': Config.googleClientId,
      'redirect_uri': '${Config.callbackUrlScheme}:/',
      'scope': 'email',
    });

    final result = await FlutterWebAuth.authenticate(
        url: url.toString(), callbackUrlScheme: Config.callbackUrlScheme);

    final code = Uri.parse(result).queryParameters['code'];

    final queryParameters = {
      'code': code,
    };
    final serverUrl = Uri.https(
        Config.serverURL, '/api/v1/auth/google/verify', queryParameters);

    await http.get(serverUrl, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });
  }
}
