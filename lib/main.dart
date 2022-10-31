import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:uni_links/uni_links.dart';

import 'config/config.dart';
import 'config/route.dart';
import 'screens/home_screen.dart';

void main() async {
  await Future.delayed(const Duration(seconds: 2));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _initialURILinkHandled = false;
  Uri? _initialURI;
  Uri? _currentURI;
  Object? _err;

  StreamSubscription? _streamSubscription;

  Future<void> _initURIHandler() async {
    if (!_initialURILinkHandled) {
      _initialURILinkHandled = true;
      Fluttertoast.showToast(
          msg: "Invoked _initURIHandler",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white);
      try {
        final initialURI = await getInitialUri();
        if (initialURI != null) {
          debugPrint("Initial URI received $initialURI");
          if (!mounted) {
            return;
          }
          setState(() {
            _initialURI = initialURI;
          });
        } else {
          debugPrint("Null Initial URI received");
        }
      } on PlatformException {
        debugPrint("Failed to receive initial uri");
      } on FormatException catch (err) {
        if (!mounted) {
          return;
        }
        debugPrint('Malformed Initial URI received');
        setState(() => _err = err);
      }
    }
  }

  void _incomingLinkHandler() {
    if (!kIsWeb) {
      _streamSubscription = uriLinkStream.listen((Uri? uri) {
        if (!mounted) {
          return;
        }
        debugPrint('Received URI: $uri');
        setState(() {
          _currentURI = uri;
          _err = null;
        });
      }, onError: (Object err) {
        if (!mounted) {
          return;
        }
        debugPrint('Error occurred: $err');
        setState(() {
          _currentURI = null;
          if (err is FormatException) {
            _err = err;
          } else {
            _err = null;
          }
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initURIHandler();
    _incomingLinkHandler();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: Config.appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
    );
  }

  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: RoutePath.defaultPath,
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
      ),
      // GoRoute(
      //   path: RoutePath.loginPath,
      //   builder: (BuildContext context, GoRouterState state) {
      //     return const LoginScreen();
      //   },
      // ),
    ],
  );
}
