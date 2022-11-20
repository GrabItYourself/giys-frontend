import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/config/config.dart';
import 'package:giys_frontend/controllers/auth.dart';
import 'package:giys_frontend/controllers/image_picker.dart';
import 'package:giys_frontend/controllers/my_menu.dart';
import 'package:requests/requests.dart';

class CRUDItemController extends GetxController {
  final authController = Get.find<AuthController>();
  final myMenuController = Get.find<MyMenuController>();
  final imagePickerController = Get.put(ImagePickerController());
  RxString imageBase64 = "".obs;
  RxString mode = "".obs;
  final nameController = TextEditingController();
  final priceController = TextEditingController();

  setMode(String mode) {
    print(mode);
    if (mode != "CREATE" && mode != "EDIT") {
      throw Exception("Unsupported mode");
    } else {
      this.mode.value = mode;
    }
  }

  Future<void> createItem(int shopId) async {
    if (mode.value != "CREATE") {
      throw Exception("Illegal Op: create");
    }
    if (imagePickerController.imagePath.value.isNotEmpty) {
      final imageFile = File(imagePickerController.imagePath.value);
      final imageBytes = await imageFile.readAsBytes();
      imageBase64.value = base64Encode(imageBytes);
    }
    print(shopId);
    print(nameController.text);
    print(priceController.text);
    try {
      final response = await Requests.post(
          '${Config.getServerUrl()}/api/v1/shops/$shopId/items/',
          headers: {
            'Content-Type': 'application/json',
          },
          json: {
            'shop_id': shopId,
            'name': nameController.text,
            'image': null,
            'price': int.parse(priceController.text),
          });
      response.raiseForStatus();
      print(response);
      clearForm();
      myMenuController.setShopId(shopId);
    } on HTTPException catch (err) {
      Get.snackbar("Cannot add/edit item", err.response.body);
      return Future.error(err.response.body);
    } catch (err) {
      return Future.error(err);
    }
  }

  void clearForm() {
    nameController.clear();
    priceController.clear();

    imagePickerController.imagePath.value = "";
  }

  setDefaultValue(String name, int price, String image) {
    if (mode.value != "EDIT") {
      throw Exception("Illegal Op: edit");
    }
    imageBase64.value = image;
    nameController.value = TextEditingValue(text: name);
    priceController.value = TextEditingValue(text: price.toString());
  }

  Future<void> editItem(int shopId, int itemId) async {
    if (mode.value != "EDIT") {
      throw Exception("Illegal Op: edit");
    }
    if (imagePickerController.imagePath.value.isNotEmpty) {
      final imageFile = File(imagePickerController.imagePath.value);
      final imageBytes = await imageFile.readAsBytes();
      imageBase64.value = base64Encode(imageBytes);
    }
    try {
      final response = await Requests.put(
          '${Config.getServerUrl()}/api/v1/shops/$shopId/items/$itemId',
          headers: {
            'Content-Type': 'application/json',
          },
          json: {
            'shop_id': shopId,
            'name': nameController.text,
            'image': null,
            'price': priceController.text,
          });
      response.raiseForStatus();
      print(response);
      clearForm();
      myMenuController.setShopId(shopId);
    } on HTTPException catch (err) {
      print(err);
      Get.snackbar("Cannot add/edit item", err.response.body);
      return Future.error(err.response.body);
    } catch (err) {
      return Future.error(err);
    }
  }

  Future<void> deleteItem(int shopId, int itemId) async {
    try {
      final response = await Requests.delete(
        '${Config.getServerUrl()}/api/v1/shops/$shopId/items/$itemId',
        headers: {
          'Content-Type': 'application/json',
        },
      );
      response.raiseForStatus();
      print(response);
      clearForm();
      myMenuController.setShopId(shopId);
    } on HTTPException catch (err) {
      Get.snackbar("Cannot add/edit item", err.response.body);
      return Future.error(err.response.body);
    } catch (err) {
      return Future.error(err);
    }
  }
}
