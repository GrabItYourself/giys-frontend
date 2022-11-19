import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/config/route.dart';
import 'package:giys_frontend/controllers/auth.dart';
import 'package:giys_frontend/widget/generic_dialog.dart';

import '../widget/scaffold.dart';

class SettingsView extends StatelessWidget {
  SettingsView({super.key});
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
        title: "Settings",
        body: ListView(
          children: <Widget>[
            ListTile(
              title: const Center(child: Text('Payment')),
              onTap: () => {Get.snackbar("TODO PAYMENT", "PAYMENT")},
            ),
            ListTile(
              title: const Center(child: Text('My Shop')),
              onTap: () {
                if (authController.shopId.value != null) {
                  Get.toNamed(RoutePath.shopOwnerPath);
                } else {
                  showGenericDialog(
                      context: context,
                      title: "You have no shop",
                      content: "You have no shop",
                      optionsBuilder: () => {"OK": null});
                }
              },
            ),
            ListTile(
              title: const Center(child: Text('Manage Shop')),
              onTap: () => {Get.toNamed(RoutePath.shopManagePath)},
            ),
            ListTile(
              title: const Center(child: Text('Logout')),
              onTap: () => {Get.snackbar("TODO LOGOUT", "LOGOUT")},
            ),
          ],
        ));
  }
}
