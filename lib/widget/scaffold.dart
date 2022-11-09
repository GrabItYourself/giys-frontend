import 'package:flutter/material.dart';

import 'drawer.dart';

class MainScaffold extends StatelessWidget {
  final String title;
  final Widget? body;
  const MainScaffold({super.key, required this.title, this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      drawer: MainDrawer(),
      body: body,
    );
  }
}
