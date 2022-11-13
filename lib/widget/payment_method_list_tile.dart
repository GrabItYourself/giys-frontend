import 'package:flutter/material.dart';

class PaymentMethodListTile extends StatelessWidget {
  final String lastFourDigits;
  final bool isDefault;
  final Future<void> Function() onTap;

  const PaymentMethodListTile({
    super.key,
    required this.lastFourDigits,
    required this.isDefault,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(lastFourDigits),
      trailing: (isDefault) ? const Text("default") : null,
      onTap: () => onTap(),
    );
  }
}
