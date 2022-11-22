import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:requests/requests.dart';

import '../config/config.dart';
import '../config/route.dart';
import '../models/shop.dart';
import 'auth.dart';

class ListItem {
  String label;
  String value;
  ListItem(this.label, this.value);
}

class ShopManageEditController extends GetxController {
  final authController = Get.find<AuthController>();

  final shopOwnerCounts = 1.obs;
  final shopOwnerControllers = <TextEditingController>[].obs;

  final shopNameController = TextEditingController();
  final shopDescriptionController = TextEditingController();
  final shopLocationController = TextEditingController();
  final shopContactController = TextEditingController();

  final imagePath = "".obs;
  final imageBase64 = "".obs;
  final _picker = ImagePicker();

  final shopId = "".obs;

  final bankAccountNameController = TextEditingController();
  final bankAccountNumberController = TextEditingController();
  final bankAccountBrandController = "".obs;
  final bankAccountTypeController = "".obs;

  static List<ListItem> bankList = [
    ListItem("Kasikornbank", "kbank"),
    ListItem("Siam Commercial Bank", "scb"),
  ];

  static List<ListItem> typeList = [
    ListItem("Individual", "individual"),
    ListItem("Corporation", "corporation"),
  ];

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

  @override
  void onInit() {
    super.onInit();
    String? id = Get.parameters['shopId'];
    if (id == null) {
      Get.offAndToNamed(RoutePath.shopManagePath);
      return;
    }
    shopId.value = id;
    _initializedFormValue(shopId.value);
    // shopOwnerControllers.last.text = authController.email.value;
  }

  String? required(String? value, String errorMsg) {
    if (value == null || value.isEmpty) {
      return errorMsg;
    }
    return null;
  }

  String formatAccountNumber(String value) {
    String temp = "";
    for (int i = 0; i < value.length; i++) {
      if (i % 4 == 0 && i != 0) {
        temp += " ";
      }
      temp += value[i];
    }
    return temp;
  }

  void createShopOwnerTextFormField(String? email) {
    if (email == null) {
      shopOwnerControllers.add(TextEditingController());
    } else {
      shopOwnerControllers.add(TextEditingController(text: email));
    }
  }

  void setBankAccountBank(String? value) {
    bankAccountBrandController.value = value!;
  }

  void setBankAccountType(String? value) {
    bankAccountTypeController.value = value!;
  }

  void removeShopOwnerTextFormField(int index) {
    shopOwnerControllers.removeAt(index);
  }

  void clearShopOwnerTextFormField() {
    shopOwnerCounts.value = 1;
    shopOwnerControllers.clear();
    createShopOwnerTextFormField(null);
  }

  void clearForm() {
    shopNameController.clear();
    shopDescriptionController.clear();
    shopLocationController.clear();
    shopContactController.clear();
    shopOwnerControllers.clear();
    clearShopOwnerTextFormField();
  }

  Future<void> _initializedFormValue(String shopId) async {
    try {
      final response = await Requests.get(
        '${Config.getServerUrl()}/api/v1/shops/$shopId',
        headers: {
          'Content-Type': 'application/json',
        },
      );
      response.raiseForStatus();
      final data = response.json();
      final shop = Shop.fromJson(data["shop"]);

      shopNameController.text = shop.name;
      shopDescriptionController.text = shop.description ?? "";
      shopLocationController.text = shop.location ?? "";
      shopContactController.text = shop.contact ?? "";

      imageBase64.value = shop.image ?? "";

      if (shop.bankAccount != null) {
        bankAccountNameController.text = shop.bankAccount!.name;
        bankAccountNumberController.text =
            formatAccountNumber(shop.bankAccount!.number);
        bankAccountBrandController.value = shop.bankAccount!.brand;
        bankAccountTypeController.value = shop.bankAccount!.type;
      }

      if (shop.owners == null) {
        clearShopOwnerTextFormField();
      } else {
        shopOwnerCounts.value = shop.owners?.length ?? 0;
        shopOwnerControllers.clear();
        shop.owners?.forEach((shopOwner) {
          createShopOwnerTextFormField(shopOwner.email);
        });
      }
    } on HTTPException catch (err) {
      Get.snackbar("Cannot edit shop", err.response.body);
      return Future.error(err.response.body);
    } catch (err) {
      Get.snackbar("Error", err.toString());
      return Future.error(err.toString());
    }
  }

  Future<void> _editOwners() async {
    try {
      final ownerEmails = shopOwnerControllers
          .map((e) => e.text)
          .where((email) => email.isNotEmpty)
          .toList();
      final response = await Requests.put(
          '${Config.getServerUrl()}/api/v1/shops/$shopId/owners',
          headers: {
            'Content-Type': 'application/json',
          },
          json: {
            'shopId': shopId.value,
            'owner_emails': ownerEmails,
          });
      response.raiseForStatus();
    } on HTTPException catch (err) {
      Get.snackbar("Cannot edit shop owners", err.response.body);
      return Future.error(err.response.body);
    } catch (err) {
      Get.snackbar("Error", err.toString());
      return Future.error(err.toString());
    }
  }

  Future<void> submitForm() async {
    try {
      _editOwners();
      final data = {
        'edited_shop': {
          'id': int.parse(shopId.value),
          'name': shopNameController.text,
          'image': imageBase64.value != "" ? imageBase64.value : null,
          'description': shopDescriptionController.text,
          'location': shopLocationController.text,
          'contact': shopContactController.text,
          'owners': [], // This will not be used in backend
          'bank_account': {
            "name": bankAccountNameController.text,
            "number": bankAccountNumberController.text.replaceAll(" ", ""),
            "brand": bankAccountBrandController.value,
            "type": bankAccountTypeController.value,
          }
        }
      };
      final response = await Requests.put(
          '${Config.getServerUrl()}/api/v1/shops/${shopId.value}',
          headers: {
            'Content-Type': 'application/json',
          },
          json: data);
      response.raiseForStatus();
      Get.offAndToNamed(RoutePath.shopManagePath);
    } on HTTPException catch (err) {
      Get.snackbar("Cannot edit shop", err.response.body);
      return Future.error(err.response.body);
    }
  }
}
