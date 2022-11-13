import 'package:get/get.dart';
import 'package:giys_frontend/models/order.dart';
import 'package:giys_frontend/models/shop.dart';
import 'package:requests/requests.dart';

import '../config/config.dart';

// TODO: get my shop id
class ShopOrderController extends GetxController {
  final orders = <Order>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await updateShopOrders();
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

  Future<void> updateShopOrders() async {
    orders.value = await getShopOrders(1);
  }

  Future<List<Order>> getShopOrders(int shopId) async {
    final response = await Requests.get(
      '${Config.getServerUrl()}/api/v1/shops/$shopId/orders',
      headers: {
        'Content-Type': 'application/json',
      },
    );
    response.raiseForStatus();
    final orders = (response.json()["result"] as List)
        .map((json) => Order.fromJson(json))
        .toList();

    final shop = await getShop(shopId);
    for (var order in orders) {
      order.shop = shop;
    }

    return orders;
  }

  Future<void> cancelOrder(int index) async {
    final response = await Requests.patch(
      '${Config.getServerUrl()}/api/v1/shops/${orders[index].shopId}/orders/${orders[index].id}/cancel',
      headers: {
        'Content-Type': 'application/json',
      },
    );
    response.raiseForStatus();

    orders[index].status = response.json()["status"];
    orders.refresh();
  }

  Future<void> readyOrder(int index) async {
    final response = await Requests.patch(
      '${Config.getServerUrl()}/api/v1/shops/${orders[index].shopId}/orders/${orders[index].id}/ready',
      headers: {
        'Content-Type': 'application/json',
      },
    );
    response.raiseForStatus();

    orders[index].status = response.json()["status"];
    orders.refresh();
  }

  Future<void> completeOrder(int index) async {
    final response = await Requests.patch(
      '${Config.getServerUrl()}/api/v1/shops/${orders[index].shopId}/orders/${orders[index].id}/complete',
      headers: {
        'Content-Type': 'application/json',
      },
    );
    response.raiseForStatus();

    orders[index].status = response.json()["status"];
    orders.refresh();
  }
}
