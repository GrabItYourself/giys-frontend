import 'package:flutter/material.dart';

class DividerWithText extends StatelessWidget {
  final String text;
  const DividerWithText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          margin: const EdgeInsets.only(left: 16, right: 16),
          child: const Divider(
            color: Colors.black,
            height: 36,
          ),
        )),
        Text(text),
        Expanded(
            child: Container(
          margin: const EdgeInsets.only(left: 16, right: 16),
          child: const Divider(
            color: Colors.black,
            height: 36,
          ),
        )),
      ],
    );
  }
}
