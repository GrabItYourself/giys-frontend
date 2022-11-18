import 'dart:io';

import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/models/user.dart';
import 'package:requests/requests.dart';

import '../config/config.dart';
import '../config/route.dart';
import '../consts/role.dart';

final googleAuthUrl = Uri.https('accounts.google.com', '/o/oauth2/v2/auth', {
  'response_type': 'code',
  'client_id': Config.getGoogleClientId(),
  'redirect_uri': '${Config.getCallbackUrlScheme()}:/',
  'scope': 'email',
});

class AuthController extends GetxController {
  final id = RxnString();
  final role = Rxn<Role>();
  final email = RxnString();
  final googleId = RxnString();
  final shopId = RxnInt();
  final isLoggedIn = RxBool(false);

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
      print(response.json());
      await getUserInfo();
    } catch (err) {
      return Future.error(err);
    }
  }

  Future<void> signOut() async {
    try {
      final response = await Requests.post(
          '${Config.getServerUrl()}/api/v1/auth/signout',
          headers: {
            'Content-Type': 'application/json',
          });
      response.raiseForStatus();
      id.value = null;
      role.value = null;
      email.value = null;
      googleId.value = null;
      shopId.value = null;
      isLoggedIn.value = false;
    } catch (err) {
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
    shopId.value = me.shopId;
    isLoggedIn.value = true;
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
