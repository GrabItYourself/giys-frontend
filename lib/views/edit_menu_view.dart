import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/config/route.dart';
import 'package:giys_frontend/controllers/crud_item.dart';
import 'package:giys_frontend/models/shop_item.dart';
import 'package:giys_frontend/widget/image_picker.dart';
import 'package:giys_frontend/widget/image_picker_base64.dart';

class EditMenuView extends StatelessWidget {
  const EditMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Menu Item")),
      body: const SafeArea(
          child: Padding(
        padding: EdgeInsets.all(16),
        child: EditMenuForm(),
      )),
    );
  }
}

class EditMenuForm extends StatefulWidget {
  const EditMenuForm({super.key});

  @override
  State<StatefulWidget> createState() {
    return _EditMenuFormState();
  }
}

// TODO image form field
class _EditMenuFormState extends State<StatefulWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final CRUDItemController createOrEditItemController =
      Get.put(CRUDItemController());
  var arg = Get.arguments;
  late final ShopItem shopItem;
  @override
  void initState() {
    createOrEditItemController.setMode(arg[2]);
    if (arg[2] == "EDIT") {
      shopItem = arg[1];
      createOrEditItemController.setDefaultValue(
          shopItem.name, shopItem.price, shopItem.image ?? "");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Form(
              key: _formKey,
              child: Column(children: [
                Obx(() => ImagePickerBase64Widget(
                      pickImage: createOrEditItemController.pickImage,
                      imageBase64: createOrEditItemController.imageBase64.value,
                    )),
                TextFormField(
                  controller: createOrEditItemController.nameController,
                  decoration: const InputDecoration(labelText: "Item Name"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Item name is required';
                    }
                    return null;
                  },
                ),
                TextFormField(
                    controller: createOrEditItemController.priceController,
                    decoration: const InputDecoration(labelText: "Price"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Price is required';
                      }
                      if (!value.isNumericOnly) {
                        return 'Price has to be an integer';
                      }
                      return null;
                    }),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                          onPressed: () =>
                              Get.toNamed(RoutePath.shopOwnerMenuPath),
                          child: const Text("Cancel")),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        child: ElevatedButton.icon(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // TODO send request
                                String chosenMode =
                                    createOrEditItemController.mode.value;
                                if (chosenMode == "CREATE") {
                                  createOrEditItemController.createItem(arg[0]);
                                } else if (chosenMode == "EDIT") {
                                  createOrEditItemController.editItem(
                                      arg[0], shopItem.id);
                                }
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Saving...")));
                              }
                            },
                            icon: const Icon(Icons.save),
                            label: const Text("Save"))),
                  ],
                ),
              ])),
        )
      ],
    );
  }
}
