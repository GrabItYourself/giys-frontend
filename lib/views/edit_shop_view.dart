import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/controllers/edit_shop.dart';

import '../widget/image_picker.dart';

class EditShopView extends StatelessWidget {
  const EditShopView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Shop")),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(child: EditShopForm()),
      )),
    );
  }
}

class EditShopForm extends StatelessWidget {
  final editShopController = Get.put(EditShopController());
  final _formKey = GlobalKey<FormState>();

  EditShopForm({super.key});

  @override
  Widget build(BuildContext context) {
    editShopController.getShopData();

    return Form(
        key: _formKey,
        child: Column(children: [
          Obx(() => ImagePickerWidget(
                pickImage: editShopController.imagePickerController.pickImage,
                imagePath:
                    editShopController.imagePickerController.imagePath.value,
              )),
          TextFormField(
            controller: editShopController.shopNameController,
            decoration: const InputDecoration(labelText: "Shop name"),
            validator: (value) =>
                editShopController.required(value, "Shop name is required"),
          ),
          TextFormField(
              controller: editShopController.shopDescriptionController,
              decoration: const InputDecoration(labelText: "Shop Description")),
          TextFormField(
              controller: editShopController.shopLocationController,
              decoration: const InputDecoration(labelText: "Location")),
          TextFormField(
              controller: editShopController.shopContactController,
              decoration: const InputDecoration(labelText: "Contact")),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: editShopController.submitForm,
                    child: const Text(
                      'Submit',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]));
  }
}
