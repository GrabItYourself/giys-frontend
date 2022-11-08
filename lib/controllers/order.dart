import 'package:get/get.dart';
import 'package:giys_frontend/models/order.dart';

class OrderController extends GetxController {
  final orders = <Order>[].obs;

  @override
  void onInit() async {
    super.onInit();
    try {
      orders.value = await getOrders();
    } catch (err) {
      return Future.error(err);
    }
  }

  Future<List<Order>> getOrders() async {
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

    var shops = await Future.wait(orders.map(((order) => getShop(order))));
    shops.asMap().forEach((idx, shop) {
      orders[idx].shop = shop;
    });
    return orders;
  }

  Future<String> getShop(Order order) async {
    await Future.delayed(const Duration(seconds: 1));
    return "${order.userId} shop";
  }

  Future<void> cancelOrder(int index) async {
    await Future.delayed(const Duration(seconds: 1));
    orders.removeAt(index);
  }
}
