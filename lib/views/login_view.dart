import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/controllers/auth.dart';
import 'package:giys_frontend/widget/login_widget.dart';

class LoginView extends StatelessWidget {
  final authController = Get.put(AuthController());

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(
          children: [
            LoginWidget(onLogin: authController.authenticate),
            Text(authController.isAuthenticated.value
                ? 'Authenticated'
                : 'Not Authenticated'),
            TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("/", (route) => false);
                },
                child: const Text("Debug (Go to Main Page)")),
          ],
        ),
      ),
    ));
  }
}
