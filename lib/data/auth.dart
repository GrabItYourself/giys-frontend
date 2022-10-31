import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:giys_frontend/config/config.dart';
import 'package:http/http.dart' as Http;

class AuthService {
  String basePath = '${Config.serverURL}/auth';
  AuthService();

  Future<void> loginWithGoogle(BuildContext context) async {
    var response = await Http.get(Uri.parse('$basePath/google'));
    print(json.decode(response.body));
  }
}
