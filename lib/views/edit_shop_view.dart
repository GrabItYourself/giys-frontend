import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/config/route.dart';

class EditShopView extends StatelessWidget {
  const EditShopView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Shop")),
      body: const SafeArea(
          child: Padding(
        padding: EdgeInsets.all(16),
        child: EditShopForm(),
      )),
    );
  }
}

class EditShopForm extends StatefulWidget {
  const EditShopForm({super.key});

  @override
  State<StatefulWidget> createState() {
    return _EditShopFormState();
  }
}

// TODO image form field
class _EditShopFormState extends State<StatefulWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: [
          TextFormField(
            decoration: const InputDecoration(labelText: "Shop Name"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Shop name is required';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: "Description"),
            maxLines: 3,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: "Location"),
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: "Contact"),
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                    onPressed: () => Get.toNamed(RoutePath.shopOwnerPath),
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
