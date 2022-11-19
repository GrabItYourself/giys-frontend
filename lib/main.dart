import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:giys_frontend/controllers/shop_create.dart';
import 'package:giys_frontend/controllers/shop_manage_edit.dart';
import 'package:giys_frontend/middlewares/admin_binding.dart';
import 'package:giys_frontend/middlewares/user_middleware.dart';
import 'package:giys_frontend/views/shop_create_view.dart';
import 'package:giys_frontend/views/edit_menu_view.dart';
import 'package:giys_frontend/views/edit_shop_view.dart';
import 'package:giys_frontend/views/home/all_shop_view.dart';
import 'package:giys_frontend/views/home/shop_detail_view.dart';
import 'package:giys_frontend/views/home/shop_menu_view.dart';
import 'package:giys_frontend/views/menu_owner_view.dart';
import 'package:giys_frontend/views/shop_manage_edit_view.dart';
import 'package:giys_frontend/views/shop_owner_view.dart';
import 'package:giys_frontend/config/route.dart';
import 'package:giys_frontend/views/order_detail_view.dart';
import 'package:giys_frontend/views/shop_orders_view.dart';
import 'package:giys_frontend/views/orders_view.dart';
import 'package:giys_frontend/views/settings_view.dart';

import 'package:giys_frontend/views/payment_method_view.dart';
import 'package:giys_frontend/views/add_payment_method_view.dart';
import 'controllers/auth.dart';
import 'controllers/shop_manage.dart';
import 'views/home_view.dart';
import 'views/shop_manage_view.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
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
        GetPage(name: RoutePath.shopDetailPath, page: () => ShopDetailView()),
        GetPage(name: RoutePath.allShopPath, page: () => AllShopView()),
        GetPage(
          name: RoutePath.shopMenuPath,
          page: () => ShopMenuView(),
        ),
        // User related routes
        GetPage(
            name: RoutePath.shopOwnerPath,
            page: () => ShopOwnerView(),
            middlewares: [UserMiddleware()]),
        GetPage(
            name: RoutePath.editShopPath,
            page: () => const EditShopView(),
            middlewares: [UserMiddleware()]),
        GetPage(name: RoutePath.shopOwnerPath, page: () => ShopOwnerView()),
        GetPage(
          name: RoutePath.paymentMethodPath,
          page: () => PaymentMethodView(),
          middlewares: [UserMiddleware()],
        ),
        GetPage(
          name: RoutePath.addPaymentMethodPath,
          page: () => AddPaymentMethodView(),
          middlewares: [UserMiddleware()],
        ),
        GetPage(
            name: RoutePath.shopOwnerMenuPath,
            page: () => const MenuOwnerView(),
            middlewares: [UserMiddleware()]),
        GetPage(
          name: RoutePath.ordersPath,
          page: () => OrdersView(),
          middlewares: [UserMiddleware()],
        ),
        GetPage(
          name: RoutePath.shopOrdersPath,
          page: () => ShopOrdersView(),
          middlewares: [UserMiddleware()],
        ),
        GetPage(
          name: RoutePath.orderDetailPath,
          page: (() => OrderDetailView()),
          middlewares: [UserMiddleware()],
        ),
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
            page: () => const ShopCreateView(),
            binding: BindingsBuilder(() {
              Get.put(ShopCreateController());
            }),
            middlewares: [AdminMiddleware()]),

        GetPage(
            name: RoutePath.shopManagePath,
            page: () => ShopManageView(),
            binding: BindingsBuilder(() {
              Get.put(ShopManageController());
            }),
            middlewares: [AdminMiddleware()]),
        GetPage(
            name: RoutePath.shopManageEditPath,
            page: () => const ShopManageEditView(),
            binding: BindingsBuilder(() {
              Get.put(ShopManageEditController());
            }),
            middlewares: [AdminMiddleware()]),
      ],
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
