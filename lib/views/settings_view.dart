import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/scaffold.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
        body: ListView(
      children: <Widget>[
        ListTile(
          title: const Center(child: Text('Payment')),
          onTap: () => {Get.snackbar("TODO PAYMENT", "PAYMENT")},
        ),
        ListTile(
          title: const Center(child: Text('My Shop')),
          onTap: () => {Get.snackbar("TODO MY SHOP", "MY SHOP")},
        ),
        ListTile(
          title: const Center(child: Text('Manage Shop')),
          onTap: () => {Get.snackbar("TODO MANAGE", "MANAGE")},
        ),
        ListTile(
          title: const Center(child: Text('Logout')),
          onTap: () => {Get.snackbar("TODO LOGOUT", "LOGOUT")},
        ),
      ],
    ));
  }
}
