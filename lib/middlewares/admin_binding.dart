import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/config/route.dart';

import '../consts/role.dart';
import '../controllers/auth.dart';

class AdminMiddleware extends GetMiddleware {
  final authController = Get.find<AuthController>();

  @override
  RouteSettings? redirect(String? route) {
    return authController.role.value == Role.admin ||
            route == RoutePath.loginPath
        ? null
        : const RouteSettings(name: RoutePath.loginPath);
  }
}
