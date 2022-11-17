import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/config/route.dart';

import '../consts/role.dart';
import '../controllers/auth.dart';
import '../widget/scaffold.dart';
import '../widget/sign_in_with_google.dart';
import '../widget/sign_out.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var publicPages = [];

    var authenticatedPages = [
      ListTile(
        title: const Text("My Shop"),
        onTap: () => Get.toNamed(RoutePath.shopOwnerPath),
      ),
      ListTile(
        title: const Text("Payment Methods"),
        onTap: () => Get.toNamed(RoutePath.paymentMethodPath),
      ),
      ListTile(
        title: const Text("Settings"),
        onTap: () => Get.toNamed(RoutePath.settingsPath),
      ),
      ListTile(
        title: const Text("Shop orders"),
        onTap: () => Get.toNamed(RoutePath.shopOrdersPath),
      ),
    ];

    var adminPages = [
      ListTile(
        title: const Text("Create Shop"),
        onTap: () => Get.toNamed(RoutePath.shopCreatePath),
      ),
      ListTile(
        title: const Text("Manage Shops"),
        onTap: () => Get.toNamed(RoutePath.shopManagePath),
      ),
    ];

    return MainScaffold(
        title: "Home",
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                GetX<AuthController>(
                  builder: (controller) {
                    final isLoggedIn = controller.email.value != '';
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: isLoggedIn
                            ? [
                                Text("Hello, ${controller.email.value}",
                                    style:
                                        Theme.of(context).textTheme.headline6),
                                const SizedBox(height: 16),
                                SignOutWidget(onSignOut: controller.signOut)
                              ]
                            : [
                                SignInWithGoogleWidget(
                                    onLogin: controller.authenticate)
                              ]);
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  "All Available Routes",
                  textScaleFactor: 2,
                ),
                const SizedBox(height: 20),
                Expanded(child: GetX<AuthController>(builder: (controller) {
                  if (controller.role.value == Role.admin) {
                    return ListView(children: [
                      ...publicPages,
                      ...authenticatedPages,
                      ...adminPages
                    ]);
                  } else if (controller.role.value == Role.user) {
                    return ListView(
                        children: [...publicPages, ...authenticatedPages]);
                  }
                  return ListView(
                    children: [...publicPages],
                  );
                }))
              ],
            ),
          ),
        ));
  }
}
