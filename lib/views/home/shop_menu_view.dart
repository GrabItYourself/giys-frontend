import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/controllers/auth.dart';
import 'package:giys_frontend/models/shop_item.dart';
import 'package:giys_frontend/views/home/shop_detail_view.dart';
import 'package:giys_frontend/utilitties/generic_dialog.dart';
import 'package:http/http.dart' as http;

import '../../models/shop.dart';

class ShopMenuView extends StatefulWidget {
  final Shop shop;
  const ShopMenuView({super.key, required this.shop});

  @override
  State<ShopMenuView> createState() => _ShopMenuViewState();
}

class _ShopMenuViewState extends State<ShopMenuView> {
  //TODO complete this function
  Future<List<ShopItem>> getAllShopItem(int shopId) async {
    List<ShopItem> allShopItem = [];
    final response = await http.get(
      Uri.http(
        "localhost:8080",
        "/api/v1/shops/$shopId/items",
      ),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
    );
    log(response.toString());
    for (var shopItem in jsonDecode(response.body)) {
      allShopItem.add(ShopItem.fromJson(shopItem));
    }

    return allShopItem;
  }

  late final List<ShopItem> shopItemsList;
  late final Map<ShopItem, int> shopCart;
  @override
  void initState() {
    // TODO: get all shop items
    final shopId = widget.shop.id;
    getAllShopItem(shopId).then((value) {
      shopItemsList = value;
      for (ShopItem shopItem in shopItemsList) {
        shopCart[shopItem] = 0;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Shop Menu")),
      body: Column(
        children: [
          widget.shop.image != null
              ? Image.network(
                  widget.shop.image!,
                  fit: BoxFit.fitWidth,
                )
              : Image.network(
                  "https://picsum.photos/200",
                  fit: BoxFit.fitWidth,
                ),
          Text(widget.shop.name),
          Row(
            children: [
              Text(widget.shop.description ?? ""),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ShopDetailView(shop: widget.shop),
                  ));
                },
                child: const Text("See More"),
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: shopItemsList.length,
              itemBuilder: (context, index) {
                final shopItem = shopItemsList[index];
                return ListTile(
                  leading: shopItem.image != null
                      ? Image.network(
                          shopItem.image!,
                          fit: BoxFit.fitWidth,
                        )
                      : Image.network(
                          "https://picsum.photos/200",
                          fit: BoxFit.fitWidth,
                        ),
                  title: Text(shopItem.name),
                  subtitle: Text(shopItem.price.toString()),
                  trailing: Wrap(
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              shopCart[shopItem] = shopCart[shopItem]! + 1;
                            });
                          },
                          icon: const Icon(Icons.add)),
                      Text(shopCart[shopItem].toString()),
                      IconButton(
                          onPressed: () {
                            if (shopCart[shopItem]! > 0) {
                              setState(() {
                                shopCart[shopItem] = shopCart[shopItem]! - 1;
                              });
                            }
                          },
                          icon: const Icon(Icons.remove))
                    ],
                  ),
                );
              },
            ),
          ),
          TextButton(
              onPressed: () async {
                final bool order;
                order = await showGenericDialog(
                  context: context,
                  title: "Confirm Order",
                  content: shopCart.toString(),
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
