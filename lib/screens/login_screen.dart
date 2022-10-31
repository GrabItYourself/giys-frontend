import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:giys_frontend/config/route.dart';
import 'package:giys_frontend/data/auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  _loginWithGoogle(BuildContext context) async {
    var authService = AuthService();
    await authService.loginWithGoogle(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () => _loginWithGoogle(context),
              child: const Text('Login'),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back'))
          ],
        ),
      ),
    );
  }
}
