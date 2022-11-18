import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:requests/requests.dart';

import '../config/config.dart';
import '../config/route.dart';
import 'auth.dart';
import 'image_picker.dart';

class ListItem {
  String label;
  String value;
  ListItem(this.label, this.value);
}

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

  final bankAccountNameController = TextEditingController();
  final bankAccountNumberController = TextEditingController();
  final bankAccountBankController = "".obs;
  final bankAccountTypeController = "".obs;

  static List<ListItem> bankList = [
    ListItem("Kasikornbank", "kbank"),
    ListItem("Siam Commercial Bank", "scv"),
  ];

  static List<ListItem> typeList = [
    ListItem("Individual", "individual"),
    ListItem("Corporation", "corporation"),
  ];

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

  void setBankAccountBank(String? value) {
    bankAccountBankController.value = value!;
  }

  void setBankAccountType(String? value) {
    bankAccountTypeController.value = value!;
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

    bankAccountNameController.clear();
    bankAccountNumberController.clear();
    bankAccountBankController.value = "";
    bankAccountTypeController.value = "";

    createShopOwnerTextFormField();
  }

  Future<void> submitForm() async {
    String? imageBase64;
    if (imagePickerController.imagePath.value.isNotEmpty) {
      final imageFile = File(imagePickerController.imagePath.value);
      final imageBytes = await imageFile.readAsBytes();
      imageBase64 = base64Encode(imageBytes);
    }

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
            'bank_account': {
              "name": bankAccountNameController.text,
              "number": bankAccountNumberController.text,
              "brand": bankAccountBankController.value,
              "type": bankAccountTypeController.value,
            }
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
