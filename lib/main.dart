import 'package:flutter/material.dart';
import 'package:giys_frontend/screens/default_view.dart';
import 'package:giys_frontend/screens/login_view.dart';
import 'package:giys_frontend/screens/payment_method_view.dart';
import 'package:go_router/go_router.dart';

import 'const/route.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'App',
      routerConfig: _router,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }

  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: defaultViewRoute,
        builder: (BuildContext context, GoRouterState state) {
          return DefaultView();
        },
      ),
      GoRoute(
        path: loginViewRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginView();
        },
      ),
      GoRoute(
        path: paymentMethodRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const PaymentMethodView();
        },
      ),
    ],
  );
}
