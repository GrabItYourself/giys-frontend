import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/controllers/auth.dart';
import 'package:giys_frontend/widget/login_widget.dart';

import '../widget/scaffold.dart';

class LoginView extends StatelessWidget {
  final authController = Get.put(AuthController());

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
        title: "Login",
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                LoginWidget(onLogin: authController.authenticate),
                GetX<AuthController>(
                  builder: (controller) {
                    return Text(authController.id.value != ''
                        ? 'Authenticated'
                        : 'Not Authenticated');
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
