import 'package:flutter/material.dart';
import 'package:giys_frontend/const/route.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () async {
                GoRouter.of(context).go(defaultViewRoute);
              },
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
