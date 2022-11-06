import 'dart:io';

import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:requests/requests.dart';

import '../config/config.dart';

final googleAuthUrl = Uri.https('accounts.google.com', '/o/oauth2/v2/auth', {
  'response_type': 'code',
  'client_id': Config.googleClientId,
  'redirect_uri': '${Config.callbackUrlScheme}:/',
  'scope': 'email',
});

class AuthController extends GetxController {
  final _accessToken = ''.obs;
  final _refreshToken = ''.obs;
  var isAuthenticated = false.obs;
  var storage = GetStorage();

  @override
  void onInit() {
    _accessToken.listen((p0) {
      storage.write('accessToken', p0);
    });
    _refreshToken.listen((p0) {
      storage.write('refreshToken', p0);
    });
    super.onInit();
  }

  Future<void> authenticate() async {
    final result = await FlutterWebAuth.authenticate(
        url: googleAuthUrl.toString(),
        callbackUrlScheme: Config.callbackUrlScheme);

    final code = Uri.parse(result).queryParameters['code'];

    // System value https://api.flutter.dev/flutter/package-platform_platform/Platform/operatingSystemValues-constant.html
    final queryParameters = {
      'code': code,
      'clientType': Platform.operatingSystem
    };

    final response =
        await Requests.get('${Config.serverUrl}/api/v1/auth/google/verify',
            headers: {
              'Content-Type': 'application/json',
            },
            queryParameters: queryParameters);
    response.raiseForStatus();
    final jsonResponse = response.json();

    // Set access token and refresh token in controller
    _accessToken.value = jsonResponse['access_token'];
    _refreshToken.value = jsonResponse['refresh_token'];
  }

  void refresh() {}
}
