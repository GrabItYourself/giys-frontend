import 'package:get/get.dart';
import 'package:giys_frontend/models/order.dart';
import 'package:giys_frontend/models/shop.dart';
import 'package:requests/requests.dart';

import '../config/config.dart';

class OrderController extends GetxController {
  final orders = <Order>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await updateMyOrders();
  }

  Future<void> updateMyOrders() async {
    try {
      orders.value = await getMyOrders();
      orders.refresh();
    } on HTTPException catch (err) {
      Get.snackbar("Cannot get orders", err.response.body);
    }
  }

  Future<List<Order>> getMyOrders() async {
    final response = await Requests.get(
      '${Config.getServerUrl()}/api/v1/user/orders',
      headers: {
        'Content-Type': 'application/json',
      },
    );
    response.raiseForStatus();
    if (response.json()["result"] == null) {
      return <Order>[];
    }

    final orders = (response.json()["result"] as List)
        .map((json) => Order.fromJson(json))
        .toList();

    return orders;
  }

  Future<void> cancelOrder(int index) async {
    try {
      final response = await Requests.patch(
        '${Config.getServerUrl()}/api/v1/shops/${orders[index].shopId}/orders/${orders[index].id}/cancel',
        headers: {
          'Content-Type': 'application/json',
        },
      );
      response.raiseForStatus();

      orders[index].status = response.json()["status"];
      orders.refresh();
    } on HTTPException catch (err) {
      Get.snackbar("Cannot cancel order", err.response.body);
    }
  }
}
