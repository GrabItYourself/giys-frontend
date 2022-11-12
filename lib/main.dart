import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:giys_frontend/controllers/create_shop.dart';
import 'package:giys_frontend/controllers/image_picker.dart';
import 'package:giys_frontend/middlewares/admin_binding.dart';
import 'package:giys_frontend/middlewares/user_middleware.dart';
import 'package:giys_frontend/views/create_shop_view.dart';
import 'package:giys_frontend/views/edit_menu_view.dart';
import 'package:giys_frontend/views/edit_shop_view.dart';
import 'package:giys_frontend/views/login_view.dart';
import 'package:giys_frontend/views/menu_owner_view.dart';
import 'package:giys_frontend/views/shop_owner_view.dart';
import 'package:giys_frontend/config/route.dart';
import 'package:giys_frontend/views/settings_view.dart';

import 'controllers/auth.dart';
import 'controllers/shop_manage.dart';
import 'views/home_view.dart';
import 'views/shop_manage_view.dart';

void main() async {
  await GetStorage.init();
  await Future.delayed(const Duration(seconds: 2));
  await dotenv.load(fileName: ".env");
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: RoutePath.defaultPath,
      theme: ThemeData(useMaterial3: true),
      getPages: [
        GetPage(name: RoutePath.defaultPath, page: () => const HomeView()),
        GetPage(name: RoutePath.loginPath, page: () => LoginView()),
        // User related routes
        GetPage(
            name: RoutePath.shopOwnerPath,
            page: () => ShopOwnerView(),
            middlewares: [UserMiddleware()]),
        GetPage(
            name: RoutePath.editShopPath,
            page: () => const EditShopView(),
            middlewares: [UserMiddleware()]),
        GetPage(
            name: RoutePath.shopOwnerMenuPath,
            page: () => const MenuOwnerView(),
            middlewares: [UserMiddleware()]),
        GetPage(
            name: RoutePath.editMenuPath,
            page: () => const EditMenuView(),
            middlewares: [UserMiddleware()]),
        GetPage(
            name: RoutePath.settingsPath,
            page: () => const SettingsView(),
            middlewares: [UserMiddleware()]),
        // Admin related routes
        GetPage(
            name: RoutePath.shopCreatePath,
            page: () => const CreateShopView(),
            binding: BindingsBuilder(() {
              Get.put(CreateShopController());
            }),
            middlewares: [AdminMiddleware()]),
        GetPage(
            name: RoutePath.shopManagePath,
            page: () => ShopManageView(),
            binding: BindingsBuilder(() {
              Get.put(ShopManageController());
            }),
            middlewares: [AdminMiddleware()]),
      ],
    );
  }
}
