import 'dart:convert';

import 'package:get/get.dart';
import 'package:giys_frontend/models/order.dart';

class ShopOrderController extends GetxController {
  // final shop = Shop().obs;
  final orders = <Order>[].obs;

  @override
  void onInit() async {
    super.onInit();
    orders.value = await getShopOrders();
  }

  Future<List<Order>> getShopOrders() async {
    // ignore: todo
    // TODO: get shop id

    // final response = await Requests.get(
    //   '${Config.serverUrl}/api/v1/shops/${shopId}/orders',
    //   headers: {
    //     'Content-Type': 'application/json',
    //   },
    // );
    // response.raiseForStatus();
    // final orders =
    //     jsonDecode(response.body).map((json) => Order.fromJson(json));

    // TODO: add shop to order

    // return orders;

    await Future.delayed(const Duration(seconds: 1));
    final orders = <Order>[];
    orders.add(Order(
      id: 1,
      userId: "1",
      shopId: 1,
      status: "COMPLETED",
      items: <OrderItem>[],
    ));
    orders.add(Order(
      id: 2,
      userId: "2",
      shopId: 1,
      status: "COMPLETED",
      items: <OrderItem>[],
    ));
    orders.add(Order(
      id: 3,
      userId: "3",
      shopId: 1,
      status: "READY",
      items: <OrderItem>[],
    ));
    orders.add(Order(
      id: 4,
      userId: "4",
      shopId: 1,
      status: "IN_QUEUE",
      items: <OrderItem>[],
    ));

    // var shops = await Future.wait(orders.map(((order) => getShop(order))));
    // shops.asMap().forEach((idx, shop) {
    //   orders[idx].shop = shop;
    // });
    return orders;
  }

  Future<String> getShop(Order order) async {
    await Future.delayed(const Duration(seconds: 1));
    return "${order.userId} shop";
  }

  Future<void> cancelOrder(int index) async {
    // final response = await Requests.patch(
    //   '${Config.serverUrl}/api/v1/user/orders/cancel',
    //   headers: {
    //     'Content-Type': 'application/json',
    //   },
    // );
    // response.raiseForStatus();

    await Future.delayed(const Duration(seconds: 1));
    orders[index].status = "CANCELED";
    orders.refresh();
  }

  Future<void> readyOrder(int index) async {
    // final response = await Requests.patch(
    //   '${Config.serverUrl}/api/v1/user/orders/ready',
    //   headers: {
    //     'Content-Type': 'application/json',
    //   },
    // );
    // response.raiseForStatus();

    await Future.delayed(const Duration(seconds: 1));
    orders[index].status = "READY";
    orders.refresh();
  }

  Future<void> completeOrder(int index) async {
    // final response = await Requests.patch(
    //   '${Config.serverUrl}/api/v1/user/orders/confirm',
    //   headers: {
    //     'Content-Type': 'application/json',
    //   },
    // );
    // response.raiseForStatus();

    await Future.delayed(const Duration(seconds: 1));
    orders[index].status = "COMPLETED";
    orders.refresh();
  }
}
