import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/widget/image_picker.dart';
import 'package:giys_frontend/widget/scaffold.dart';

import '../controllers/shop_create.dart';

class ShopCreateView extends StatelessWidget {
  const ShopCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: "Create Shop",
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(child: ShopCreateForm()),
      )),
    );
  }
}

class ShopCreateForm extends StatelessWidget {
  final createShopController = Get.find<ShopCreateController>();
  final _loginFormKey = GlobalKey<FormState>();

  ShopCreateForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _loginFormKey,
        child: Column(children: [
          Obx(() => ImagePickerWidget(
                pickImage: createShopController.imagePickerController.pickImage,
                imagePath:
                    createShopController.imagePickerController.imagePath.value,
              )),
          TextFormField(
            controller: createShopController.shopNameController,
            decoration: const InputDecoration(labelText: "Shop name"),
            validator: (value) =>
                createShopController.required(value, "Shop name is required"),
          ),
          TextFormField(
              controller: createShopController.shopDescriptionController,
              decoration: const InputDecoration(labelText: "Shop Description"),
              validator: (value) => createShopController.required(
                  value, "Shop description is required")),
          TextFormField(
              controller: createShopController.shopContactController,
              decoration: const InputDecoration(labelText: "Contact"),
              validator: (value) =>
                  createShopController.required(value, "Contact is required")),
          TextFormField(
              controller: createShopController.shopLocationController,
              decoration: const InputDecoration(labelText: "Location"),
              validator: (value) =>
                  createShopController.required(value, "Location is required")),
          Obx(() => Container(
                margin: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Shop Owners",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        IconButton(
                            onPressed: createShopController
                                .createShopOwnerTextFormField,
                            icon: const Icon(Icons.add)),
                      ],
                    ),
                    for (var index = 0;
                        index <
                            createShopController.shopOwnerControllers.length;
                        index++)
                      Row(
                        children: [
                          Flexible(
                            child: TextFormField(
                              controller: createShopController
                                  .shopOwnerControllers[index],
                              decoration: InputDecoration(
                                labelText: 'Shop Owner ${index + 1}',
                              ),
                              validator: (value) => createShopController
                                  .required(value, 'Shop Owner is required'),
                            ),
                          ),
                          IconButton(
                              onPressed: () => createShopController
                                  .removeShopOwnerTextFormField(index),
                              icon: const Icon(Icons.remove)),
                        ],
                      )
                  ],
                ),
              )),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    child: const Text(
                      'Submit',
                    ),
                    onPressed: createShopController.submitForm,
                  ),
                ),
              ],
            ),
          ),
        ]));
  }
}
