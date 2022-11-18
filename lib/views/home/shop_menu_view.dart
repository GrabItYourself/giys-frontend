import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/config/route.dart';
import 'package:giys_frontend/controllers/order_send.dart';
import 'package:giys_frontend/controllers/payment_method.dart';
import 'package:giys_frontend/controllers/shops_item.dart';
import 'package:giys_frontend/models/payment_method.dart';
import 'package:giys_frontend/models/shop_item.dart';
import 'package:giys_frontend/utilitties/generic_dialog.dart';
import 'package:giys_frontend/widget/scaffold.dart';

import '../../models/shop.dart';

class ShopMenuView extends StatefulWidget {
  final Shop shop = Get.arguments;
  ShopMenuView({super.key});

  @override
  State<ShopMenuView> createState() => _ShopMenuViewState();
}

class _ShopMenuViewState extends State<ShopMenuView> {
  late final ShopItemsController shopItemsController =
      Get.put(ShopItemsController());
  // final OrderSendController orderSendController =
  //     Get.put(OrderSendController());
  late final Map<ShopItem, int> shopCart = {};
  late final int shopId;

  @override
  void initState() {
    shopId = widget.shop.id;
    shopItemsController.getAllShopItems(shopId);
    for (ShopItem shopItem in shopItemsController.shopItemsList) {
      shopCart[shopItem] = 0;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
        title: "Shop Menu",
        body: SafeArea(child: GetX<ShopItemsController>(
          builder: (controller) {
            print(shopId);
            return Column(
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
                Text(widget.shop.description ?? ""),
                TextButton(
                  onPressed: () {
                    Get.toNamed(RoutePath.shopDetailPath,
                        arguments: widget.shop);
                  },
                  child: const Text("See More"),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.shopItemsList.length,
                    itemBuilder: (context, index) {
                      final shopItem = controller.shopItemsList[index];
                      return ListTile(
                        leading: shopItem.image != null
                            ? Image.memory(
                                base64Decode(shopItem.image),
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
                                    shopCart[shopItem] =
                                        (shopCart[shopItem] ?? 0) + 1;
                                  });
                                },
                                icon: const Icon(Icons.add)),
                            Text((shopCart[shopItem] ?? 0).toString()),
                            IconButton(
                                onPressed: () {
                                  if ((shopCart[shopItem] ?? 0) > 0) {
                                    setState(() {
                                      shopCart[shopItem] =
                                          shopCart[shopItem]! - 1;
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
                      final bool sendOrder;
                      sendOrder = await showGenericDialog(
                        context: context,
                        title: "Confirm Order",
                        content: shopCart.toString(),
                        optionsBuilder: () => {
                          "Order": true,
                          "Cancel": false,
                        },
                      );
                      if (sendOrder) {
                        //TODO check if user has credit card
                        final PaymentMethodController paymentMethodController =
                            Get.find();
                        final List<PaymentMethod> paymentList =
                            paymentMethodController.paymentMethods;
                        PaymentMethod? defaultPayment =
                            paymentList.firstWhereOrNull(
                                (element) => element.isDefault == true);
                        print(paymentMethodController.paymentMethods);
                        if (defaultPayment != null) {
                          //TODO user has credit card, send order
                          //convert shopCart to order
                          // orderSendController.sendOrder(shopId, order);
                          print("User has credit card");
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
            );
          },
        )));
  }
}
