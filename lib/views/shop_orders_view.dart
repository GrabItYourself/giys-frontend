import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/controllers/shop_order.dart';
import 'package:giys_frontend/widget/order_card.dart';

import '../widget/scaffold.dart';

class ShopOrdersView extends StatelessWidget {
  final shopOrderController = Get.put(ShopOrderController());

  ShopOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: "Shop Orders",
      body: SafeArea(
        child: Center(
          child: GetX<ShopOrderController>(
            builder: (controller) => RefreshIndicator(
              onRefresh: controller.updateShopOrders,
              child: ListView.builder(
                itemCount: controller.orders.length,
                itemBuilder: (context, index) => OrderCard(
                  isOwner: true,
                  order: controller.orders[index],
                  onReady: (() => controller.readyOrder(index)),
                  onComplete: (() => controller.completeOrder(index)),
                  onCancel: (() => controller.cancelOrder(index)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
