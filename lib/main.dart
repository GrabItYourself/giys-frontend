import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:giys_frontend/views/edit_menu_view.dart';
import 'package:giys_frontend/views/edit_shop_view.dart';
import 'package:giys_frontend/views/login_view.dart';
import 'package:giys_frontend/views/menu_owner_view.dart';
import 'package:giys_frontend/views/shop_owner_view.dart';
import 'package:giys_frontend/config/route.dart';
import 'controllers/auth.dart';
import 'views/home_view.dart';

void main() async {
  await GetStorage.init();
  await Future.delayed(const Duration(seconds: 2));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        GetPage(name: RoutePath.shopOwnerPath, page: () => ShopOwnerView()),
        GetPage(name: RoutePath.editShopPath, page: () => const EditShopView()),
        GetPage(
            name: RoutePath.shopOwnerMenuPath,
            page: () => const MenuOwnerView()),
        GetPage(name: RoutePath.editMenuPath, page: () => const EditMenuView())
      ],
      routingCallback: (routing) async => _handleAuthGaurd,
    );
  }
}
