import 'package:flutter/material.dart';

class ShopOrdersView extends StatefulWidget {
  const ShopOrdersView({super.key});

  @override
  State<ShopOrdersView> createState() => _ShopOrdersViewState();
}

class _ShopOrdersViewState extends State<ShopOrdersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: const Text("Shop Orders")),
    );
  }
}
