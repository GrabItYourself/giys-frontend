import 'package:flutter/material.dart';
import 'package:giys_frontend/utilitties/generic_dialog.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late final String userId;
  @override
  void initState() {
    // TODO: implement getUserId
    userId = "";
    super.initState();
  }

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
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => const PaymentMethodView()));
            },
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text("Payment"),
            ),
          ),
          TextButton(
            onPressed: () async {
              //TODO check if haveShop ? navigateTo shop : push error popup
              // final bool userHasShop = true;
              // if (userHasShop) {
              //   Navigator.of(context).push(MaterialPageRoute(
              //       builder: (context) => const ShopDetailOwnerView()));
              // } else {
              //   await showGenericDialog(
              //     context: context,
              //     title: "No Shop",
              //     content: "You do not have shop",
              //     optionsBuilder: (() => {"OK": null}),
              //   );
              // }
            },
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text("My Shop"),
            ),
          ),
          TextButton(
            onPressed: () {
              //TODO logout logic
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
