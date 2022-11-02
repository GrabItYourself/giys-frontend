import 'package:flutter/material.dart';
import 'package:giys_frontend/data/shop.dart';

class ShopDetailOwnerEditView extends StatefulWidget {
  const ShopDetailOwnerEditView({super.key});

  @override
  State<ShopDetailOwnerEditView> createState() =>
      _ShopDetailOwnerEditViewState();
}

class _ShopDetailOwnerEditViewState extends State<ShopDetailOwnerEditView> {
  late final TextEditingController _nameController;
  late final TextEditingController _contactController;
  late final TextEditingController _descController;
  late final TextEditingController _bankAccountController;
  late final TextEditingController _locationController;

  //TODO get current user from existing backend
  late final Shop userShop;
  @override
  void initState() {
    //get user shop from user id
    userShop = Shop(
      id: 23,
      name: "Name",
      contact: "Contact",
      desc: "desc",
      image: null,
      location: "loc",
    );
    super.initState();
    _nameController = TextEditingController(text: userShop.name);
    _contactController = TextEditingController(text: userShop?.contact ?? "");
    _descController = TextEditingController(text: userShop?.desc ?? "");
    _locationController = TextEditingController(text: userShop?.location ?? "");
    _bankAccountController = TextEditingController(text: "Bank Num");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _contactController.dispose();
    _descController.dispose();
    _locationController.dispose();
    _bankAccountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Shop Details")),
      body: Column(
        children: [
          //TODO add image editing
          Image.network(
            userShop.image ?? "",
            fit: BoxFit.fitWidth,
          ),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(hintText: "Name"),
          ),
          TextField(
            controller: _descController,
            decoration: const InputDecoration(hintText: "Description"),
          ),
          TextField(
            controller: _locationController,
            decoration: const InputDecoration(hintText: "Location"),
          ),
          TextField(
            controller: _contactController,
            decoration: const InputDecoration(hintText: "Contact"),
          ),
          //TODO find out where bankAccount is
          TextField(
            controller: _bankAccountController,
            decoration: const InputDecoration(hintText: "Bank Number"),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }
}
