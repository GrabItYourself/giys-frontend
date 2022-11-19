import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/config/route.dart';
import 'package:giys_frontend/controllers/auth.dart';
import 'package:giys_frontend/controllers/my_shop.dart';
import 'package:requests/requests.dart';
import '../config/config.dart';
import 'image_picker.dart';

class EditShopController extends GetxController {
  final authController = Get.find<AuthController>();
  final imagePickerController = Get.put(ImagePickerController());

  final myShopController = Get.put(MyShopController());

  RxInt shopId = 1.obs;
  RxString imageBase64 = "".obs;

  final shopNameController = TextEditingController();
  final shopDescriptionController = TextEditingController();
  final shopLocationController = TextEditingController();
  final shopContactController = TextEditingController();

  // TODO get shop id from user credentials
  @override
  void onInit() async {
    super.onInit();
    try {
      final shopData = await myShopController.getMyShop(1);
      shopId.value = shopData.shop.id;
      imageBase64.value = shopData.shop.image ?? '';
      shopNameController.value = TextEditingValue(text: shopData.shop.name);
      shopDescriptionController.value =
          TextEditingValue(text: shopData.shop.description ?? '');
      shopLocationController.value =
          TextEditingValue(text: shopData.shop.location ?? '');
      shopContactController.value =
          TextEditingValue(text: shopData.shop.contact ?? '');
    } catch (err) {
      return Future.error(err);
    }
  }

  String? required(String? value, String errorMsg) {
    if (value == null || value.isEmpty) {
      return errorMsg;
    }
    return null;
  }

  void clearForm() {
    shopNameController.clear();
    shopDescriptionController.clear();
    shopLocationController.clear();
    shopContactController.clear();
    imagePickerController.imagePath.value = "";
  }

  Future<void> submitForm() async {
    if (imagePickerController.imagePath.value.isNotEmpty) {
      final imageFile = File(imagePickerController.imagePath.value);
      final imageBytes = await imageFile.readAsBytes();
      imageBase64.value = base64Encode(imageBytes);
    }

    // TODO get shop id from user credentials
    try {
      final response = await Requests.put(
          '${Config.getServerUrl()}/api/v1/shops/${1}',
          headers: {
            'Content-Type': 'application/json',
          },
          json: {
            'edited_shop': {
              'id': shopId.value,
              'name': shopNameController.text,
              'image': imageBase64.value,
              'description': shopDescriptionController.text,
              'location': shopLocationController.text,
              'contact': shopContactController.text,
            }
          });
      response.raiseForStatus();
      clearForm();
      Get.toNamed(RoutePath.shopOwnerPath);
    } on HTTPException catch (err) {
      Get.snackbar("Cannot edit shop", err.response.body);
      return Future.error(err.response.body);
    }
  }

  // TODO get shop id from user credentials
  getShopData() async {
    try {
      final shopData = await myShopController.getMyShop(1);
      shopId.value = shopData.shop.id;
      imageBase64.value = shopData.shop.image ?? '';
      shopNameController.value = TextEditingValue(text: shopData.shop.name);
      shopDescriptionController.value =
          TextEditingValue(text: shopData.shop.description ?? '');
      shopLocationController.value =
          TextEditingValue(text: shopData.shop.location ?? '');
      shopContactController.value =
          TextEditingValue(text: shopData.shop.contact ?? '');
    } catch (err) {
      return Future.error(err);
    }
  }
}
