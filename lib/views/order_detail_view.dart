import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/controllers/order.dart';
import 'package:giys_frontend/controllers/order_detail.dart';
import 'package:giys_frontend/widget/order_card.dart';

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
                child: Text("${item.shopItemId}"),
              ),
              (item.note.isEmpty)
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "note: ${item.note}",
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
        0: FractionColumnWidth(0.1),
        1: FractionColumnWidth(0.4),
        2: FractionColumnWidth(0.5),
      },
      children: rows,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: SafeArea(
        child: Center(
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Image.network(
                        "https://picsum.photos/200",
                        fit: BoxFit.cover,
                        width: 100,
                      ),
                      const SizedBox(width: 8),
                      Column(
                        children: [
                          const Text("shop card"),
                          Text(orderDetailController.order.value.shopId
                              .toString()),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () => print("to shop"),
                        icon: const Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    "Order Detail",
                    textAlign: TextAlign.left,
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(10),
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
