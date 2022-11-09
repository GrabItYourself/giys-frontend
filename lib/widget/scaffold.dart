import 'package:flutter/material.dart';

import '../config/config.dart';
import 'drawer.dart';

class MainScaffold extends StatelessWidget {
  final Widget? body;
  const MainScaffold({super.key, this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Config.getAppName())),
      drawer: MainDrawer(),
      body: body,
    );
  }
}
