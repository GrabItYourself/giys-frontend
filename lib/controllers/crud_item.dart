import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/config/config.dart';
import 'package:giys_frontend/controllers/auth.dart';
import 'package:giys_frontend/controllers/my_menu.dart';
import 'package:image_picker/image_picker.dart';
import 'package:requests/requests.dart';

class CRUDItemController extends GetxController {
  final authController = Get.find<AuthController>();
  final myMenuController = Get.find<MyMenuController>();
  final imagePath = "".obs;
  final imageBase64 = "".obs;
  final _picker = ImagePicker();
  RxString mode = "".obs;
  final nameController = TextEditingController();
  final priceController = TextEditingController();

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

  setMode(String mode) {
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
    try {
      var data = {
        'shop_id': shopId,
        'name': nameController.text,
        'image': imageBase64.value != "" ? imageBase64.value : null,
        'price': int.parse(priceController.text),
      };
      final response = await Requests.post(
          '${Config.getServerUrl()}/api/v1/shops/$shopId/items/',
          headers: {
            'Content-Type': 'application/json',
          },
          json: data);
      response.raiseForStatus();
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
    try {
      final response = await Requests.put(
          '${Config.getServerUrl()}/api/v1/shops/$shopId/items/$itemId',
          headers: {
            'Content-Type': 'application/json',
          },
          json: {
            'edited_item': {
              'shop_id': shopId,
              'id': itemId,
              'name': nameController.text,
              'image': imageBase64.value != "" ? imageBase64.value : null,
              'price': int.parse(priceController.text),
            }
          });
      response.raiseForStatus();
      clearForm();
      myMenuController.setShopId(shopId);
    } on HTTPException catch (err) {
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
