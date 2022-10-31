import 'package:flutter/material.dart';
import 'package:giys_frontend/const/route.dart';
import 'package:giys_frontend/views/login_view.dart';
import 'package:giys_frontend/views/setting/payment_method_view.dart';

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
              )),
          TextButton(
              onPressed: () {
                //TODO get user if has shop go to shop, else push error screen
              },
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text("My Shop"),
              )),
          TextButton(
              onPressed: () {
                //TODO logout logic
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(loginViewRoute, (route) => false);
              },
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text("Logout"),
              )),
        ],
      ),
    );
  }
}
