import 'package:flutter/material.dart';
import 'package:giys_frontend/services/auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  _loginWithGoogle(BuildContext context) async {
    var authService = AuthService();
    await authService.authenticate(context);
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
