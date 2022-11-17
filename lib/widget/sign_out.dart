import 'package:flutter/material.dart';

class SignOutWidget extends StatelessWidget {
  final Future<void> Function() onSignOut;

  const SignOutWidget({
    super.key,
    required this.onSignOut,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.red),
            color: Colors.red[50],
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: TextButton(
            onPressed: onSignOut,
            child: const Text(
              'Sign Out',
              style: TextStyle(color: Colors.red),
            )));
  }
}
