import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:giys_frontend/views/default_view.dart';
import 'package:giys_frontend/views/login_view.dart';

void main() async {
  await GetStorage.init();
  await Future.delayed(const Duration(seconds: 2));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/', page: () => DefaultView()),
        GetPage(name: '/login', page: () => LoginView()),
      ],
    );
  }
}