import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:requests/requests.dart';

import '../config/config.dart';
import '../config/route.dart';
import 'auth.dart';
import 'image_picker.dart';

class ShopCreateController extends GetxController {
  final authController = Get.find<AuthController>();
  final imagePickerController = Get.put(ImagePickerController());

  final shopOwnerCounts = 1.obs;
  final shopOwnerControllers = <TextEditingController>[].obs;

  final shopNameController = TextEditingController();
  final shopDescriptionController = TextEditingController();
  final shopLocationController = TextEditingController();
  final shopContactController = TextEditingController();
  final bankAccountController = TextEditingController();

  @override
  void onInit() {
    createShopOwnerTextFormField();
    // shopOwnerControllers.last.text = authController.email.value;
    super.onInit();
  }

  String? required(String? value, String errorMsg) {
    if (value == null || value.isEmpty) {
      return errorMsg;
    }
    return null;
  }

  void createShopOwnerTextFormField() {
    shopOwnerControllers.add(TextEditingController());
  }

  void removeShopOwnerTextFormField(int index) {
    shopOwnerControllers.removeAt(index);
  }

  void clearForm() {
    shopNameController.clear();
    shopDescriptionController.clear();
    shopLocationController.clear();
    shopContactController.clear();
    bankAccountController.clear();
    shopOwnerControllers.clear();
    shopOwnerCounts.value = 1;
    imagePickerController.imagePath.value = "";
    createShopOwnerTextFormField();
  }

  Future<void> submitForm() async {
    if (imagePickerController.imagePath.value.isEmpty) {
      Get.snackbar('Error', 'Please fill all the fields');
      return;
    }

    final image = File(imagePickerController.imagePath.value);
    final imageBytes = image.readAsBytesSync();
    String imageBase64 = base64.encode(imageBytes);

    try {
      final response = await Requests.post(
          '${Config.getServerUrl()}/api/v1/shops',
          headers: {
            'Content-Type': 'application/json',
          },
          json: {
            'name': shopNameController.text,
            'image': imageBase64,
            'description': shopDescriptionController.text,
            'location': shopLocationController.text,
            'contact': shopContactController.text,
            'owner_emails': shopOwnerControllers.map((e) => e.text).toList(),
          });
      response.raiseForStatus();
      clearForm();
      Get.toNamed(RoutePath.shopManagePath);
    } on HTTPException catch (err) {
      Get.snackbar("Cannot create shop", err.response.body);
      return Future.error(err.response.body);
    }
  }
}
