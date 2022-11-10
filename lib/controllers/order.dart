import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:giys_frontend/models/order.dart';
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
    // final response = await Requests.get(
    //   '${Config.serverUrl}/api/v1/user/orders',
    //   headers: {
    //     'Content-Type': 'application/json',
    //   },
    // );
    // response.raiseForStatus();
    // final orders =
    //     jsonDecode(response.body).map((json) => Order.fromJson(json));

    // TODO: get shop names
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
      status: "COMPLETED",
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

  Future<String> getShop(int shopId) async {
    // final response = await Requests.get(
    //   '${Config.serverUrl}/api/v1/shop/${shopId}',
    //   headers: {
    //     'Content-Type': 'application/json',
    //   },
    // );
    // response.raiseForStatus();

    // TODO: convert response to shop model

    await Future.delayed(const Duration(seconds: 1));
    return shopId.toString();
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
}
