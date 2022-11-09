import 'package:get/get.dart';
import 'package:giys_frontend/models/order.dart';
import 'dart:convert';

class OrderDetailController extends GetxController {
  final order =
      Order(id: 0, userId: '', shopId: 0, status: '', items: <OrderItem>[]).obs;

  @override
  void onInit() async {
    super.onInit();
    final shopId = int.parse(Get.parameters["shopId"]!);
    final orderId = int.parse(Get.parameters["orderId"]!);
    order.value = await getOrder(shopId, orderId);
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

  Future<Order> getOrder(int shopId, int orderId) async {
    // final response = await Requests.get(
    //   '${Config.serverUrl}/api/v1/shops/${shopId}/orders',
    //   headers: {
    //     'Content-Type': 'application/json',
    //   },
    // );
    // response.raiseForStatus();

    // final order = Order.fromJson(jsonDecode(response.body));
    // return order;

    // TODO: add shop to order, add shop items to order items

    await Future.delayed(const Duration(seconds: 1));
    return Order(
      id: orderId,
      userId: '',
      shopId: shopId,
      status: '',
      items: <OrderItem>[
        OrderItem(shopItemId: 1, quantity: 10, note: ''),
        OrderItem(
          shopItemId: 2222222222,
          quantity: 20,
          note: 'helelelelejlelelelel',
        ),
        OrderItem(shopItemId: 3, quantity: 30, note: ''),
        OrderItem(shopItemId: 4, quantity: 40, note: ''),
        OrderItem(shopItemId: 5, quantity: 50, note: ''),
      ],
    );
  }

  Future<String> getShopItem(int shopId, int shopItemId) async {
    // final response = await Requests.get(
    //   '${Config.serverUrl}/api/v1/shops/${shopId}/shopItems/${shopItemId}',
    //   headers: {
    //     'Content-Type': 'application/json',
    //   },
    // );
    // response.raiseForStatus();

    // TODO: convert response to shop item

    await Future.delayed(const Duration(seconds: 1));
    return 'shopItem $shopId $shopItemId';
  }
}
