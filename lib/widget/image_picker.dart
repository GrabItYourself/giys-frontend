import 'package:flutter/material.dart';

class ImagePickerWidget extends StatelessWidget {
  final Future<void> Function() pickImage;
  final String imagePath;

  const ImagePickerWidget({
    super.key,
    required this.pickImage,
    required this.imagePath,
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
                image: imagePath != ""
                    ? DecorationImage(
                        image: AssetImage(imagePath), fit: BoxFit.cover)
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
