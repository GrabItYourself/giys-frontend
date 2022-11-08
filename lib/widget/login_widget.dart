import 'package:flutter/material.dart';

class LoginWidget extends StatelessWidget {
  final Future<void> Function() onLogin;

  const LoginWidget({
    super.key,
    required this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: OutlinedButton(
            onPressed: onLogin, child: const Text('Login with Google')));
  }
}
