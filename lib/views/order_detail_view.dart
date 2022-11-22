import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/controllers/order_detail.dart';
import 'package:giys_frontend/config/route.dart';

import '../widget/scaffold.dart';

class OrderDetailView extends StatelessWidget {
  final orderDetailController = Get.put(OrderDetailController());

  OrderDetailView({super.key});

  String formatCreatedAt() {
    final dt = DateTime.fromMillisecondsSinceEpoch(
            orderDetailController.order.value.transaction!.createdAt)
        .toLocal();
    final dateFormat = DateFormat("yyyy-MM-dd HH:mm");
    return dateFormat.format(dt);
  }

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
                        child: (orderDetailController.order.value.shop?.image !=
                                null)
                            ? Image.memory(base64.decode(
                                orderDetailController.order.value.shop!.image!))
                            : const CircleAvatar(),
                      ),
                      const SizedBox(width: 8),
                      Text(orderDetailController.order.value.shop?.name ?? "")
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
                (orderDetailController.order.value.transaction == null)
                    ? const SizedBox.shrink()
                    : const Padding(
                        padding: EdgeInsets.only(top: 5, left: 10),
                        child: Text(
                          "Transaction",
                          style: TextStyle(
                              color: Color.fromARGB(255, 125, 125, 125)),
                          textAlign: TextAlign.left,
                        ),
                      ),
                (orderDetailController.order.value.transaction == null)
                    ? const SizedBox.shrink()
                    : Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  const Text(
                                    "Total",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                      "฿${orderDetailController.order.value.transaction!.amount ~/ 100}"),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  const Text(
                                    "Created at",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(formatCreatedAt()),
                                ],
                              ),
                            ),
                          ],
                        ),
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
