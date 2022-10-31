import 'package:flutter/material.dart';
import 'package:giys_frontend/config/route.dart';
import 'package:giys_frontend/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _onButtonPressed() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text('Home Screen'),
          TextButton(onPressed: _onButtonPressed, child: const Text('Login'))
        ],
      )),
    );
  }
}
