import 'package:flutter/material.dart';
import 'package:giys_frontend/data/shop_item.dart';

class ShopItemAddOrEditView extends StatefulWidget {
  final ShopItem? shopItem;
  const ShopItemAddOrEditView({super.key, this.shopItem});

  @override
  State<ShopItemAddOrEditView> createState() => _ShopItemAddOrEditViewState();
}

class _ShopItemAddOrEditViewState extends State<ShopItemAddOrEditView> {
  //TODO add out of stock?
  //TODO add image editing
  late final TextEditingController _nameController;
  late final TextEditingController _priceController;
  @override
  void initState() {
    // TODO: implement initState
    if (widget.shopItem != null) {
      _nameController = TextEditingController(text: widget.shopItem!.name);
      _priceController =
          TextEditingController(text: widget.shopItem!.price.toString());
    } else {
      _nameController = TextEditingController();
      _priceController = TextEditingController();
    }
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu Item"),
        actions: [
          TextButton(
            onPressed: () {
              //TODO save to database and check if this pop works
              Navigator.of(context).pop();
            },
            child: const Text("Done"),
          )
        ],
      ),
      body: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(hintText: "Name"),
          ),
          TextField(
            controller: _priceController,
            decoration: const InputDecoration(hintText: "Price"),
            keyboardType: TextInputType.number,
          ),
          if (widget.shopItem != null) ...[
            TextButton(
              onPressed: () {
                //TODO save to database and check if this pop works
                Navigator.of(context).pop();
              },
              child: const Text("Delete Item"),
            ),
          ]
        ],
      ),
    );
  }
}
