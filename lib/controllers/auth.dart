import 'dart:io';

import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/models/user.dart';
import 'package:requests/requests.dart';

import '../config/config.dart';
import '../consts/role.dart';

final googleAuthUrl = Uri.https('accounts.google.com', '/o/oauth2/v2/auth', {
  'response_type': 'code',
  'client_id': Config.getGoogleClientId(),
  'redirect_uri': '${Config.getCallbackUrlScheme()}:/',
  'scope': 'email',
});

class AuthController extends GetxController {
  final id = ''.obs;
  final role = Rx<Role?>(null);
  final email = ''.obs;
  final googleId = ''.obs;

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
      print("Future2");
      final response = await Requests.post(
          '${Config.getServerUrl()}/api/v1/auth/google/verify',
          headers: {
            'Content-Type': 'application/json',
          },
          queryParameters: queryParameters);
      print("Future2 Done");
      response.raiseForStatus();
      print(response.json());
      await getUserInfo();
    } catch (err) {
      print("Future 2 failed");
      return Future.error(err);
    }
  }

  _setStateFromMeResponse(User me) {
    id.value = me.id;
    if (me.role == 'ADMIN') {
      role.value = Role.admin;
    } else if (me.role == 'USER') {
      role.value = Role.user;
    } else {
      role.value = null;
    }
    email.value = me.email;
    googleId.value = me.googleId;
  }

  Future<User> getUserInfo() async {
    final response = await Requests.get(
      '${Config.getServerUrl()}/api/v1/user/me',
      headers: {
        'Content-Type': 'application/json',
      },
    );
    response.raiseForStatus();
    var me = User.fromJson(response.json());
    _setStateFromMeResponse(me);
    return me;
  }
}
