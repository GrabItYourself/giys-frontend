import 'package:flutter/material.dart';

import 'drawer.dart';

class MainScaffold extends StatelessWidget {
  final String title;
  final Widget? body;
  final bool? back;
  const MainScaffold({super.key, required this.title, this.body, this.back});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      drawer: back == true ? null : MainDrawer(),
      body: body,
    );
  }
}
