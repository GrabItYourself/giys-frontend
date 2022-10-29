import 'package:flutter/material.dart';

class PaymentMethodView extends StatefulWidget {
  const PaymentMethodView({super.key});

  @override
  State<PaymentMethodView> createState() => _PaymentMethodViewState();
}

class _PaymentMethodViewState extends State<PaymentMethodView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () {},
            child: const Text("Add Credit Card"),
          )
        ],
      ),
    );
  }
}
