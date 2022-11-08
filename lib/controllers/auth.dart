import 'dart:io';

import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/config/route.dart';
import 'package:giys_frontend/models/auth.dart';
import 'package:requests/requests.dart';

import '../config/config.dart';

final googleAuthUrl = Uri.https('accounts.google.com', '/o/oauth2/v2/auth', {
  'response_type': 'code',
  'client_id': Config.googleClientId,
  'redirect_uri': '${Config.callbackUrlScheme}:/',
  'scope': 'email',
});

class AuthController extends GetxController {
  // final _accessToken = ''.obs;
  // final _refreshToken = ''.obs;
  // final _storage = GetStorage();
  final id = ''.obs;
  final name = ''.obs;
  final email = ''.obs;

  @override
  void onInit() async {
    // _accessToken.listen((p0) {
    //   _storage.write('accessToken', p0);
    // });
    // _refreshToken.listen((p0) {
    //   _storage.write('refreshToken', p0);
    // });
    // if (_storage.hasData('accessToken')) {
    //   _accessToken.value = _storage.read('accessToken');
    //   isAuthenticated.value = true;
    // }
    // if (_storage.hasData('refreshToken')) {
    //   _refreshToken.value = _storage.read('refreshToken');
    // }
    super.onInit();
    try {
      final userInfo = await getUserInfo();
      id.value = userInfo.id;
      name.value = userInfo.name;
      email.value = userInfo.email;
    } catch (err) {
      Get.toNamed(RoutePath.loginPath);
      return Future.error(err);
    }
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
    // final jsonResponse = response.json();

    // Set access token and refresh token in controller
    // _accessToken.value = jsonResponse['access_token'];
    // _refreshToken.value = jsonResponse['refresh_token'];
  }

  Future<MeResponse> getUserInfo() async {
    final response = await Requests.get(
      '${Config.serverUrl}/api/v1/user/me',
      headers: {
        'Content-Type': 'application/json',
      },
    );
    response.raiseForStatus();
    return MeResponse.fromJson(response.json());
  }
}
