import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/controllers/shop_order.dart';
import 'package:giys_frontend/widget/login_widget.dart';
import 'package:giys_frontend/widget/order_card.dart';
import 'package:giys_frontend/widget/shop_order_card.dart';

import '../widget/scaffold.dart';

class ShopOrdersView extends StatelessWidget {
  final shopOrderController = Get.put(ShopOrderController());

  ShopOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: SafeArea(
        child: Center(
          child: GetX<ShopOrderController>(
            builder: (controller) => ListView.builder(
              itemCount: controller.orders.length,
              itemBuilder: (context, index) => ShopOrderCard(
                order: controller.orders[index],
                onReady: (() => controller.cancelOrder(index)),
                onComplete: (() => controller.cancelOrder(index)),
                onCancel: (() => controller.cancelOrder(index)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
