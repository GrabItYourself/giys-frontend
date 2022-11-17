import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/config/route.dart';

import '../consts/role.dart';
import '../controllers/auth.dart';
import '../widget/divider_with_text.dart';
import '../widget/scaffold.dart';
import '../widget/sign_in_with_google.dart';
import '../widget/sign_out.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var userPages = [
      ListTile(
        title: const Text("Payment Methods"),
        onTap: () => Get.toNamed(RoutePath.paymentMethodPath),
      ),
      ListTile(
        title: const Text("Settings"),
        onTap: () => Get.toNamed(RoutePath.settingsPath),
      ),
    ];

    var shopPages = [
      ListTile(
        title: const Text("My Shop"),
        onTap: () => Get.toNamed(RoutePath.shopOwnerPath),
      ),
      ListTile(
        title: const Text("Shop orders"),
        onTap: () => Get.toNamed(RoutePath.shopOrdersPath),
      )
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
            child: Center(
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: GetX<AuthController>(
                builder: (controller) {
                  if (controller.isLoggedIn.value) {
                    final List<Widget> pages = [];
                    if (controller.isLoggedIn.value) {
                      pages.addAll(userPages);
                      // TODO: check if user is shop owner
                      if (true) {
                        pages.addAll([
                          const DividerWithText(text: "Shop"),
                          ...shopPages
                        ]);
                      }
                      if (controller.role.value == Role.admin) {
                        pages.addAll([
                          const DividerWithText(text: "Admin"),
                          ...adminPages
                        ]);
                      }
                    }
                    return Column(
                      children: [
                        const Text(
                          "All Available Routes",
                          textScaleFactor: 2,
                        ),
                        const SizedBox(height: 20),
                        Text("Hello, ${controller.email.value}"),
                        const SizedBox(height: 20),
                        ListView(
                          shrinkWrap: true,
                          children: [...pages],
                        ),
                        const SizedBox(height: 20),
                        SignOutWidget(onSignOut: controller.signOut)
                      ],
                    );
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SignInWithGoogleWidget(onLogin: controller.authenticate)
                    ],
                  );
                },
              )),
        )));
  }
}
