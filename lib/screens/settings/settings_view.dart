import 'package:flutter/material.dart';
import 'package:giys_frontend/const/route.dart';
import 'package:giys_frontend/screens/settings/payment_method_view.dart';
import 'package:go_router/go_router.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const PaymentMethodView()));
            },
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text("Payment"),
            ),
          ),
          TextButton(
            onPressed: () {
              //TODO check if haveShop ? navigateTo shop : push error popup
            },
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text("My Shop"),
            ),
          ),
          TextButton(
            onPressed: () {
              //TODO logout logic
              GoRouter.of(context).go(loginViewRoute);
            },
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text("Logout"),
            ),
          ),
        ],
      ),
    );
  }
}
