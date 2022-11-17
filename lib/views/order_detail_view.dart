import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/controllers/order_detail.dart';

import '../widget/scaffold.dart';

class OrderDetailView extends StatelessWidget {
  final orderDetailController = Get.put(OrderDetailController());

  OrderDetailView({super.key});

  Widget createOrderDetailTable() {
    List<TableRow> rows = orderDetailController.order.value.items
        .map(
          (item) => TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "x${item.quantity}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child:
                    (item.shopItem == null) ? null : Text(item.shopItem!.name),
              ),
              (item.note == null || item.note!.isEmpty)
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        item.note!,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 125, 125, 125)),
                      ),
                    ),
            ],
          ),
        )
        .toList();
    return Table(
      columnWidths: const {
        0: FractionColumnWidth(0.2),
        1: FractionColumnWidth(0.4),
        2: FractionColumnWidth(0.4),
      },
      children: rows,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: "Order Details",
      body: SafeArea(
        child: Center(
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                    child: Row(
                      children: [
                        Text(
                          "Order ID: ${orderDetailController.order.value.id}",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 125, 125, 125)),
                        ),
                        const Spacer(),
                        Text(
                          orderDetailController.order.value.status,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 125, 125, 125)),
                        ),
                      ],
                    )),
                Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        alignment: Alignment.center,
                        child: (orderDetailController.order.value.shop!.image !=
                                null)
                            ? Image.memory(base64.decode(
                                orderDetailController.order.value.shop!.image!))
                            : const CircleAvatar(),
                      ),
                      const SizedBox(width: 8),
                      Text(orderDetailController.order.value.shop!.name),
                      const Spacer(),
                      IconButton(
                        // TODO: navigate to shop
                        onPressed: () => print("to shop"),
                        icon: const Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 5, left: 10),
                  child: Text(
                    "Order Details",
                    style: TextStyle(color: Color.fromARGB(255, 125, 125, 125)),
                    textAlign: TextAlign.left,
                  ),
                ),
                Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: createOrderDetailTable(),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: OutlinedButton(
                    onPressed: (() => Get.back()),
                    child: const Text("Back"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
