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
    } catch (err) {
      Get.snackbar("Cannot get orders", "Please try again");
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

    await Future.wait(orders.map((order) => updateShop(order)));

    return orders;
  }

  Future<void> updateShop(Order order) async {
    order.shop = await getShop(order.shopId);
  }

  Future<Shop> getShop(int shopId) async {
    final response = await Requests.get(
      '${Config.getServerUrl()}/api/v1/shops/$shopId',
      headers: {
        'Content-Type': 'application/json',
      },
    );
    response.raiseForStatus();

    return Shop.fromJson(response.json()["shop"]);
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
    } catch (err) {
      Get.snackbar("Cannot cancel order", "Please try again");
    }
  }
}
