import 'package:flutter/material.dart';
import 'package:giys_frontend/data/shop_item.dart';

class ShopMenuOwnerView extends StatefulWidget {
  final String shopId;
  const ShopMenuOwnerView({super.key, required this.shopId});

  @override
  State<ShopMenuOwnerView> createState() => _ShopMenuOwnerViewState();
}

class _ShopMenuOwnerViewState extends State<ShopMenuOwnerView> {
  late final List<ShopItem> shopItemsList;
  @override
  void initState() {
    // TODO: get shop menu from shopId
    shopItemsList = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shop Menu"),
        actions: [
          IconButton(
            onPressed: () {
              //TODO go to shop item add
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final shopItem = shopItemsList[index];
          return ListTile(
            leading: Image.network(shopItem.image ?? ""),
            title: Text(shopItem.name),
            subtitle: Text(shopItem.price.toString()),
            onTap: () {
              //TODO go to shop item edit
            },
          );
        },
      ),
    );
  }
}
