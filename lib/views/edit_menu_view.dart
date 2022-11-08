import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/config/route.dart';

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

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: [
          TextFormField(
            decoration: const InputDecoration(labelText: "Item Name"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Item name is required';
              }
              return null;
            },
          ),
          TextFormField(
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
                    onPressed: () => Get.toNamed(RoutePath.shopOwnerMenuPath),
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
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Saving...")));
                        }
                      },
                      icon: const Icon(Icons.save),
                      label: const Text("Save"))),
            ],
          ),
        ]));
  }
}
