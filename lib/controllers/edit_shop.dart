import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/config/route.dart';
import 'package:giys_frontend/controllers/auth.dart';
import 'package:giys_frontend/controllers/my_shop.dart';
import 'package:image_picker/image_picker.dart';
import 'package:requests/requests.dart';
import '../config/config.dart';
import 'image_picker.dart';

class EditShopController extends GetxController {
  final authController = Get.find<AuthController>();
  final imagePath = "".obs;
  final imageBase64 = "".obs;
  final _picker = ImagePicker();

  final myShopController = Get.put(MyShopController());

  final shopNameController = TextEditingController();
  final shopDescriptionController = TextEditingController();
  final shopLocationController = TextEditingController();
  final shopContactController = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    try {
      final shopData = await myShopController.getMyShop(1);
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

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
      final imageFile = File(imagePath.value);
      final imageBytes = await imageFile.readAsBytes();
      imageBase64.value = base64Encode(imageBytes);
    } else {
      print('No image selected.');
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
  }

  Future<void> submitForm(int shopId) async {
    try {
      final response = await Requests.put(
          '${Config.getServerUrl()}/api/v1/shops/$shopId',
          headers: {
            'Content-Type': 'application/json',
          },
          json: {
            'edited_shop': {
              'id': shopId,
              'name': shopNameController.text,
              'image': imageBase64.value != "" ? imageBase64.value : null,
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

  getShopData(int shopId) async {
    try {
      final shopData = await myShopController.getMyShop(shopId);
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
