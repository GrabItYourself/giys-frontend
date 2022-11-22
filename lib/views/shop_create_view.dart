import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final shopCreateController = Get.find<ShopCreateController>();
  final _loginFormKey = GlobalKey<FormState>();

  ShopCreateForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _loginFormKey,
        child: Column(children: [
          Obx(() => ImagePickerWidget(
                pickImage: shopCreateController.imagePickerController.pickImage,
                imagePath:
                    shopCreateController.imagePickerController.imagePath.value,
              )),
          TextFormField(
            controller: shopCreateController.shopNameController,
            decoration: const InputDecoration(labelText: "Shop name"),
            validator: (value) =>
                shopCreateController.required(value, "Shop name is required"),
          ),
          TextFormField(
              controller: shopCreateController.shopDescriptionController,
              decoration: const InputDecoration(labelText: "Shop Description"),
              validator: (value) => shopCreateController.required(
                  value, "Shop description is required")),
          TextFormField(
              controller: shopCreateController.shopContactController,
              decoration: const InputDecoration(labelText: "Contact"),
              validator: (value) =>
                  shopCreateController.required(value, "Contact is required")),
          TextFormField(
              controller: shopCreateController.shopLocationController,
              decoration: const InputDecoration(labelText: "Location"),
              validator: (value) =>
                  shopCreateController.required(value, "Location is required")),
          Container(
            margin: const EdgeInsets.only(top: 16),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Bank Account",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
                TextFormField(
                    controller: shopCreateController.bankAccountNameController,
                    decoration:
                        const InputDecoration(labelText: "Bank account name"),
                    validator: (value) => shopCreateController.required(
                        value, "Bank account name is required")),
                TextFormField(
                  controller: shopCreateController.bankAccountNumberController,
                  decoration:
                      const InputDecoration(labelText: "Bank account number"),
                  validator: (value) => shopCreateController.required(
                      value, "Bank account number is required"),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    LengthLimitingTextInputFormatter(16),
                  ],
                ),
                DropdownButtonFormField(
                  items: ShopCreateController.bankList
                      .map((e) => DropdownMenuItem(
                            value: e.value,
                            child: Text(e.label),
                          ))
                      .toList(),
                  onChanged: shopCreateController.setBankAccountBank,
                  hint: const Text("Select Bank"),
                ),
                DropdownButtonFormField(
                  items: ShopCreateController.typeList
                      .map((e) => DropdownMenuItem(
                            value: e.value,
                            child: Text(e.label),
                          ))
                      .toList(),
                  onChanged: shopCreateController.setBankAccountType,
                  hint: const Text("Select Type"),
                )
              ],
            ),
          ),
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
                            onPressed: shopCreateController
                                .createShopOwnerTextFormField,
                            icon: const Icon(Icons.add)),
                      ],
                    ),
                    for (var index = 0;
                        index <
                            shopCreateController.shopOwnerControllers.length;
                        index++)
                      Row(
                        children: [
                          Flexible(
                            child: TextFormField(
                              controller: shopCreateController
                                  .shopOwnerControllers[index],
                              decoration: InputDecoration(
                                labelText: 'Shop owner email ${index + 1}',
                              ),
                              validator: (value) =>
                                  shopCreateController.required(
                                      value, 'Shop owner email is required'),
                            ),
                          ),
                          IconButton(
                              onPressed: () => shopCreateController
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
                    onPressed: shopCreateController.submitForm,
                  ),
                ),
              ],
            ),
          ),
        ]));
  }
}
