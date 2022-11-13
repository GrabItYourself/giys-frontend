import 'package:get/get.dart';
import 'package:giys_frontend/models/order.dart';
import 'package:giys_frontend/models/shop.dart';
import 'package:giys_frontend/models/shop_item.dart';
import 'package:requests/requests.dart';

import '../config/config.dart';

class OrderDetailController extends GetxController {
  final order =
      Order(id: 0, userId: '', shopId: 0, status: '', items: <OrderItem>[]).obs;
  final shop = Shop(id: 0, name: '').obs;

  @override
  void onInit() async {
    super.onInit();
    final shopId = int.parse(Get.parameters["shopId"]!);
    final orderId = int.parse(Get.parameters["orderId"]!);

    shop.value = await getShop(shopId);
    order.value = await getOrder(shopId, orderId);
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

  Future<Order> getOrder(int shopId, int orderId) async {
    final response = await Requests.get(
      '${Config.getServerUrl()}/api/v1/shops/$shopId/orders/$orderId',
      headers: {
        'Content-Type': 'application/json',
      },
    );
    response.raiseForStatus();

    final order = Order.fromJson(response.json());

    await Future.wait(
        order.items.map((orderItem) => updateShopItem(shopId, orderItem)));

    return order;
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
