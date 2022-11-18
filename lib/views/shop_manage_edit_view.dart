import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/widget/scaffold.dart';

import '../controllers/shop_manage_edit.dart';
import '../widget/image_picker_base64.dart';

class ShopManageEditView extends StatelessWidget {
  const ShopManageEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: "Manage Edit Shop",
      back: true,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(child: _ShopEditForm()),
      )),
    );
  }
}

class _ShopEditForm extends StatelessWidget {
  final shopManageEditController = Get.find<ShopManageEditController>();
  final _formKey = GlobalKey<FormState>();

  _ShopEditForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: [
          Obx(() => ImagePickerBase64Widget(
                pickImage: shopManageEditController.pickImage,
                imageBase64: shopManageEditController.imageBase64.value,
              )),
          TextFormField(
            controller: shopManageEditController.shopNameController,
            decoration: const InputDecoration(labelText: "Shop name"),
            validator: (value) => shopManageEditController.required(
                value, "Shop name is required"),
          ),
          TextFormField(
              controller: shopManageEditController.shopDescriptionController,
              decoration: const InputDecoration(labelText: "Shop Description"),
              validator: (value) => shopManageEditController.required(
                  value, "Shop description is required")),
          TextFormField(
              controller: shopManageEditController.shopContactController,
              decoration: const InputDecoration(labelText: "Contact"),
              validator: (value) => shopManageEditController.required(
                  value, "Contact is required")),
          TextFormField(
              controller: shopManageEditController.shopLocationController,
              decoration: const InputDecoration(labelText: "Location"),
              validator: (value) => shopManageEditController.required(
                  value, "Location is required")),
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
                    controller:
                        shopManageEditController.bankAccountNameController,
                    decoration:
                        const InputDecoration(labelText: "Bank account name"),
                    validator: (value) => shopManageEditController.required(
                        value, "Bank account name is required")),
                TextFormField(
                  controller:
                      shopManageEditController.bankAccountNumberController,
                  decoration:
                      const InputDecoration(labelText: "Bank account number"),
                  validator: (value) => shopManageEditController.required(
                      value, "Bank account number is required"),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    LengthLimitingTextInputFormatter(16),
                  ],
                ),
                DropdownButtonFormField(
                  items: ShopManageEditController.bankList
                      .map((e) => DropdownMenuItem(
                            value: e.value,
                            child: Text(e.label),
                          ))
                      .toList(),
                  onChanged: shopManageEditController.setBankAccountBank,
                  hint: const Text("Select Bank"),
                ),
                DropdownButtonFormField(
                  items: ShopManageEditController.typeList
                      .map((e) => DropdownMenuItem(
                            value: e.value,
                            child: Text(e.label),
                          ))
                      .toList(),
                  onChanged: shopManageEditController.setBankAccountType,
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
                            onPressed: () => shopManageEditController
                                .createShopOwnerTextFormField(null),
                            icon: const Icon(Icons.add)),
                      ],
                    ),
                    for (var index = 0;
                        index <
                            shopManageEditController
                                .shopOwnerControllers.length;
                        index++)
                      Row(
                        children: [
                          Flexible(
                            child: TextFormField(
                              controller: shopManageEditController
                                  .shopOwnerControllers[index],
                              decoration: InputDecoration(
                                labelText: 'Shop Owner ${index + 1}',
                              ),
                              validator: (value) => shopManageEditController
                                  .required(value, 'Shop Owner is required'),
                            ),
                          ),
                          IconButton(
                              onPressed: () => shopManageEditController
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
                    onPressed: shopManageEditController.submitForm,
                    child: const Text(
                      'Save',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]));
  }
}
