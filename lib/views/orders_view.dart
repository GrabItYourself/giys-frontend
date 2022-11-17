import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/controllers/order.dart';
import 'package:giys_frontend/widget/order_card.dart';

import '../widget/scaffold.dart';

class OrdersView extends StatelessWidget {
  final orderController = Get.put(OrderController());

  OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: "Orders",
      body: SafeArea(
        child: Center(
          child: GetX<OrderController>(
            builder: (controller) => RefreshIndicator(
              onRefresh: controller.updateMyOrders,
              child: ListView.builder(
                itemCount: controller.orders.length,
                itemBuilder: (context, index) => OrderCard(
                  isOwner: false,
                  order: controller.orders[index],
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
