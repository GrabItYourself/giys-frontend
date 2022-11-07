import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:giys_frontend/config/route.dart';
import 'package:giys_frontend/views/login_view.dart';
import 'controllers/auth.dart';
import 'views/home_view.dart';

void main() async {
  await GetStorage.init();
  await Future.delayed(const Duration(seconds: 2));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  _handleAuthGaurd(Routing routing) async {
    try {
      if (RoutePath.protectedPaths.contains(routing.current)) {
        final authController = Get.find<AuthController>();
        await authController.getUserInfo();
      }
    } catch (err) {
      Get.toNamed(RoutePath.loginPath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: RoutePath.defaultPath,
      getPages: [
        GetPage(name: RoutePath.defaultPath, page: () => const HomeView()),
        GetPage(name: RoutePath.loginPath, page: () => LoginView()),
      ],
      routingCallback: (routing) async => _handleAuthGaurd,
    );
  }
}
