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
  final id = ''.obs;
  final role = ''.obs;
  final email = ''.obs;
  final googleId = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    try {
      print("init");
      await getUserInfo();
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

    try {
      final response =
          await Requests.post('${Config.serverUrl}/api/v1/auth/google/verify',
              headers: {
                'Content-Type': 'application/json',
              },
              queryParameters: queryParameters);
      response.raiseForStatus();
      await getUserInfo();
    } catch (err) {
      return Future.error(err);
    }
  }

  Future<MeResponse> getUserInfo() async {
    final response = await Requests.get(
      '${Config.serverUrl}/api/v1/user/me',
      headers: {
        'Content-Type': 'application/json',
      },
    );
    response.raiseForStatus();
    var me = MeResponse.fromJson(response.json());
    id.value = me.id;
    role.value = me.role;
    email.value = me.email;
    googleId.value = me.googleId;
    return me;
  }
}
