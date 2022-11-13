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
    orders.value = await getMyOrders();
  }

  Future<List<Order>> getMyOrders() async {
    final response = await Requests.get(
      '${Config.getServerUrl()}/api/v1/user/orders',
      headers: {
        'Content-Type': 'application/json',
      },
    );
    response.raiseForStatus();
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
    final response = await Requests.patch(
      '${Config.getServerUrl()}/api/v1/shops/${orders[index].shopId}/orders/${orders[index].id}/cancel',
      headers: {
        'Content-Type': 'application/json',
      },
    );
    response.raiseForStatus();

    orders[index].status = "CANCELED";
    orders.refresh();
  }
}
