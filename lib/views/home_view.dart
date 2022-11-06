import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "All Available Routes",
              textScaleFactor: 2,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: const Text("Go to Login Page"),
                    onTap: () => Get.toNamed("/login"),
                  ),
                  ListTile(
                    title: const Text("Go to My Shop"),
                    onTap: () => Get.toNamed("/my-shop"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
