import 'package:flutter/material.dart';
import 'package:giys_frontend/data/shop_item.dart';
import 'package:giys_frontend/screens/home/shop_detail_view.dart';
import 'package:giys_frontend/utilitties/generic_dialog.dart';

import '../../data/shop.dart';

class ShopMenuView extends StatefulWidget {
  final Shop shop;
  const ShopMenuView({super.key, required this.shop});

  @override
  State<ShopMenuView> createState() => _ShopMenuViewState();
}

class _ShopMenuViewState extends State<ShopMenuView> {
  late final List<ShopItem> shopItemsList;
  @override
  void initState() {
    // TODO: get all shop items
    final shopId = widget.shop.id;
    shopItemsList = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Shop Menu")),
      body: Column(
        children: [
          Image.network(
            widget.shop.image ?? "",
            fit: BoxFit.fitWidth,
          ),
          Text(widget.shop.name),
          Row(
            children: [
              Text(widget.shop.desc ?? ""),
              TextButton(
                onPressed: () {
                  MaterialPageRoute(
                    builder: (context) => ShopDetailView(shop: widget.shop),
                  );
                },
                child: const Text("See More"),
              )
            ],
          ),
          ListView.builder(
            itemBuilder: (context, index) {
              final shopItem = shopItemsList[index];
              return ListTile(
                leading: Image.network(shopItem.image ?? ""),
                title: Text(shopItem.name),
                subtitle: Text(shopItem.price.toString()),
                trailing: Wrap(
                  children: [
                    //TODO add, show, remove item from cart
                    IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
                    Text("itemCart[index]"),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.remove))
                  ],
                ),
              );
            },
          ),
          TextButton(
              onPressed: () async {
                //TODO show popup for order
                final bool order;
                order = await showGenericDialog(
                  context: context,
                  title: "Confirm Order",
                  content: "", //TODO should be itemCart
                  optionsBuilder: () => {
                    "Order": true,
                    "Cancel": false,
                  },
                );
                if (order) {
                  //TODO check if user has credit card
                  final bool userHasCreditCard = true;
                  if (userHasCreditCard) {
                    //TODO user has credit card, send order
                  } else {
                    await showGenericDialog(
                      context: context,
                      title: "No Payment Method",
                      content: "You have to add payment.",
                      optionsBuilder: () => {"OK": null},
                    );
                  }
                }
              },
              child: const Text("Checkout"))
        ],
      ),
    );
  }
}
