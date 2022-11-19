import 'dart:convert';

import 'package:flutter/material.dart';

class ImagePickerBase64Widget extends StatelessWidget {
  final Future<void> Function() pickImage;
  final String imageBase64;

  const ImagePickerBase64Widget({
    super.key,
    required this.pickImage,
    required this.imageBase64,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: pickImage,
          child: Container(
            alignment: Alignment.center,
            width: 200,
            height: 200,
            foregroundDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: imageBase64 != ""
                    ? DecorationImage(
                        image: Image.memory(base64.decode(imageBase64)).image,
                        fit: BoxFit.cover)
                    : null),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[300],
            ),
          ),
        ),
      ],
    );
  }
}
