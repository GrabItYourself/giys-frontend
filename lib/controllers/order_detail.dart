import 'package:get/get.dart';
import 'package:giys_frontend/models/order.dart';
import 'package:giys_frontend/models/shop.dart';
import 'package:giys_frontend/models/shop_item.dart';
import 'package:requests/requests.dart';

import '../config/config.dart';

class OrderDetailController extends GetxController {
  final order =
      Order(id: 0, userId: '', shopId: 0, status: '', items: <OrderItem>[]).obs;

  @override
  void onInit() async {
    super.onInit();
    try {
      await getOrderDetails();
    } on HTTPException catch (err) {
      Get.snackbar("Cannot get order details", err.response.body);
    }
  }

  Future<Order> getOrder(int shopId, int orderId) async {
    final response = await Requests.get(
      '${Config.getServerUrl()}/api/v1/shops/$shopId/orders/$orderId',
      headers: {
        'Content-Type': 'application/json',
      },
    );
    response.raiseForStatus();

    return Order.fromJson(response.json());
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

  Future<void> getOrderDetails() async {
    final orderDetails =
        await getOrder(Get.arguments['shop_id'], Get.arguments['order_id']);

    orderDetails.shop = await getShop(orderDetails.shopId);

    await Future.wait(orderDetails.items
        .map((orderItem) => updateShopItem(orderDetails.shopId, orderItem)));

    order.value = orderDetails;
  }

  Future<void> updateShopItem(int shopId, OrderItem orderItem) async {
    orderItem.shopItem = await getShopItem(shopId, orderItem.shopItemId);
  }

  Future<ShopItem> getShopItem(int shopId, int shopItemId) async {
    final response = await Requests.get(
      '${Config.getServerUrl()}/api/v1/shops/$shopId/items/$shopItemId',
      headers: {
        'Content-Type': 'application/json',
      },
    );
    response.raiseForStatus();

    return ShopItem.fromJson(response.json()["item"]);
  }
}
