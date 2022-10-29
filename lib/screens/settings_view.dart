import 'package:flutter/material.dart';
import 'package:giys_frontend/screens/payment_method_view.dart';

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
              onPressed: () {},
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text("My Shop"),
              )),
          TextButton(
              onPressed: () {},
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text("Logout"),
              )),
        ],
      ),
    );
  }
}
