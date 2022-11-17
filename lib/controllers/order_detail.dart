import 'package:get/get.dart';
import 'package:giys_frontend/models/order.dart';
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
    } catch (err) {
      Get.snackbar("Cannot get order details", "Please try again");
    }
  }

  Future<void> getOrderDetails() async {
    order.value = Get.arguments['order'] as Order;
    await Future.wait(order.value.items
        .map((orderItem) => updateShopItem(order.value.shopId, orderItem)));
    order.refresh();
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
