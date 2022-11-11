import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:requests/requests.dart';

import '../config/config.dart';
import 'auth.dart';

class CreateShopController extends GetxController {
  final shopNameController = TextEditingController();
  final shopDescriptionController = TextEditingController();
  final shopLocationController = TextEditingController();
  final shopContactController = TextEditingController();
  final bankAccountController = TextEditingController();
  final authController = Get.put(AuthController());
  final selectedImagePath = "".obs;

  @override
  void onInit() {
    // Simulating obtaining the user name from some local storage
    shopContactController.text = authController.me.id;
    super.onInit();
  }

  String? required(String? value, String errorMsg) {
    if (value == null || value.isEmpty) {
      return errorMsg;
    }
    return null;
  }

  // TODO BUG!
  Future<void> pickImage() async {
    final picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
    }
  }

  Future<void> submitForm() async {
    if (shopNameController.text.isEmpty ||
        shopDescriptionController.text.isEmpty ||
        shopLocationController.text.isEmpty ||
        shopContactController.text.isEmpty ||
        bankAccountController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill all the fields');
      return;
    }
    final response = await Requests.post(
      '${Config.getServerUrl()}/api/v1/shop',
      headers: {
        'Content-Type': 'application/json',
      },
    );
    response.raiseForStatus();
  }
}
