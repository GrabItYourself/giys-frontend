import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/config/route.dart';
import 'package:giys_frontend/controllers/order_send.dart';
import 'package:giys_frontend/controllers/payment_method.dart';
import 'package:giys_frontend/controllers/shops_item.dart';
import 'package:giys_frontend/models/order.dart';
import 'package:giys_frontend/models/payment_method.dart';
import 'package:giys_frontend/models/shop_item.dart';
import 'package:giys_frontend/widget/generic_dialog.dart';
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
  final OrderSendController orderSendController =
      Get.put(OrderSendController());
  final PaymentMethodController paymentMethodController =
      Get.put(PaymentMethodController());
  late final Map<ShopItem, int> shopCart = {};
  late final int shopId;

  @override
  void initState() {
    shopId = widget.shop.id;
    shopItemsController.getAllShopItems(shopId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
        title: "Shop Menu",
        back: true,
        body: SafeArea(child: GetX<ShopItemsController>(
          builder: (controller) {
            return Column(
              children: [
                widget.shop.image != null
                    ? SizedBox(
                        width: 200,
                        height: 200,
                        child: Image.memory(
                            base64.decode(widget.shop.image as String)))
                    : SizedBox(
                        width: 200,
                        height: 200,
                        child: DecoratedBox(
                            decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[300],
                        )),
                      ),
                const SizedBox(height: 20),
                Text(
                  widget.shop.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.shop.description ?? "",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
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
                            : SizedBox(
                                width: 50,
                                height: 50,
                                child: DecoratedBox(
                                    decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[300],
                                )),
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
                      String shopCartStr = "";
                      for (ShopItem s in shopCart.keys) {
                        shopCartStr += "${s.name}: ${shopCart[s]} \n";
                      }
                      sendOrder = await showGenericDialog(
                        context: context,
                        title: "Confirm Order",
                        content: shopCartStr,
                        optionsBuilder: () => {
                          "Order": true,
                          "Cancel": false,
                        },
                      );
                      if (sendOrder) {
                        final List<PaymentMethod> paymentList =
                            paymentMethodController.paymentMethods;
                        PaymentMethod? defaultPayment =
                            paymentList.firstWhereOrNull(
                                (element) => element.isDefault == true);
                        if (defaultPayment != null) {
                          List<OrderItem> items = [];
                          shopCart.forEach((key, value) {
                            OrderItem itm = OrderItem(
                                shopItemId: key.id, quantity: value, note: "");
                            items.add(itm);
                          });
                          final response = await orderSendController.sendOrder(
                              shopId, items);
                          Get.toNamed(RoutePath.orderDetailPath, arguments: {
                            'order_id': response["order_id"],
                            'shop_id': response["shop_id"],
                          });
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
