import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/config/route.dart';
import 'package:giys_frontend/widget/scaffold.dart';

import '../controllers/create_shop.dart';

class CreateShopView extends StatelessWidget {
  const CreateShopView({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: "Create Shop",
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: CreateShopForm(),
      )),
    );
  }
}

class CreateShopForm extends StatelessWidget {
  final createShopController = Get.put(CreateShopController());
  final _loginFormKey = GlobalKey<FormState>();

  CreateShopForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _loginFormKey,
        child: Column(children: [
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
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    child: const Text('Submit'),
                    onPressed: createShopController.submitForm,
                  ),
                ),
              ],
            ),
          ),
        ]));
  }
}
