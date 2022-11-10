import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:requests/requests.dart';

import '../config/config.dart';
import 'auth.dart';
import 'image_picker.dart';

class CreateShopController extends GetxController {
  final authController = Get.find<AuthController>();
  final imagePickerController = Get.put(ImagePickerController());

  final shopNameController = TextEditingController();
  final shopDescriptionController = TextEditingController();
  final shopLocationController = TextEditingController();
  final shopContactController = TextEditingController();
  final shopOwnerController = TextEditingController();
  final bankAccountController = TextEditingController();

  @override
  void onInit() {
    shopOwnerController.text = authController.email.value;
    super.onInit();
  }

  String? required(String? value, String errorMsg) {
    if (value == null || value.isEmpty) {
      return errorMsg;
    }
    return null;
  }

  Future<void> submitForm() async {
    if (shopNameController.text.isEmpty ||
        shopDescriptionController.text.isEmpty ||
        shopLocationController.text.isEmpty ||
        shopContactController.text.isEmpty ||
        shopOwnerController.text.isEmpty ||
        // bankAccountController.text.isEmpty ||
        imagePickerController.imagePath.value.isEmpty) {
      Get.snackbar('Error', 'Please fill all the fields');
      return;
    }

    final image = File(imagePickerController.imagePath.value);
    final imageBytes = image.readAsBytesSync();
    String imageBase64 = base64Encode(imageBytes);

    final response =
        await Requests.post('${Config.serverUrl}/api/v1/shops', headers: {
      'Content-Type': 'application/json',
    }, json: {
      'name': shopNameController.text,
      'image': imageBase64.substring(0, 100),
      'description': shopDescriptionController.text,
      'location': shopLocationController.text,
      'contact': shopContactController.text,
      'owner': shopOwnerController.text,
      // 'account': bankAccountController.text,
    });
    response.raiseForStatus();
  }
}
