import 'dart:io';

import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/config/route.dart';
import 'package:giys_frontend/models/auth.dart';
import 'package:requests/requests.dart';

import '../config/config.dart';

final googleAuthUrl = Uri.https('accounts.google.com', '/o/oauth2/v2/auth', {
  'response_type': 'code',
  'client_id': Config.getGoogleClientId(),
  'redirect_uri': '${Config.getCallbackUrlScheme()}:/',
  'scope': 'email',
});

class AuthController extends GetxController {
  final _id = ''.obs;
  final _role = ''.obs;
  final _email = ''.obs;
  final _googleId = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    try {
      await getUserInfo();
    } catch (err) {
      Get.toNamed(RoutePath.loginPath);
      return Future.error(err);
    }
  }

  Future<void> authenticate() async {
    final result = await FlutterWebAuth.authenticate(
        url: googleAuthUrl.toString(),
        callbackUrlScheme: Config.getCallbackUrlScheme());

    final code = Uri.parse(result).queryParameters['code'];

    // System value https://api.flutter.dev/flutter/package-platform_platform/Platform/operatingSystemValues-constant.html
    final queryParameters = {
      'code': code,
      'clientType': Platform.operatingSystem
    };

    try {
      final response = await Requests.post(
          '${Config.getServerUrl()}/api/v1/auth/google/verify',
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
      '${Config.getServerUrl()}/api/v1/user/me',
      headers: {
        'Content-Type': 'application/json',
      },
    );
    response.raiseForStatus();
    var me = MeResponse.fromJson(response.json());
    _id.value = me.id;
    _role.value = me.role;
    _email.value = me.email;
    _googleId.value = me.googleId;
    return me;
  }

  MeResponse get me => MeResponse(
        id: _id.value,
        role: _role.value,
        email: _email.value,
        googleId: _googleId.value,
      );
}
