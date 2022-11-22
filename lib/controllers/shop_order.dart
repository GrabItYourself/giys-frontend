import 'package:get/get.dart';
import 'package:giys_frontend/models/order.dart';
import 'package:giys_frontend/models/shop.dart';
import 'package:requests/requests.dart';
import 'auth.dart';
import '../config/config.dart';

class ShopOrderController extends GetxController {
  final authController = Get.find<AuthController>();
  final orders = <Order>[].obs;

  @override
  void onInit() async {
    super.onInit();
    if (authController.shopId.value == null) {
      Get.snackbar("You do not have any shop", "Please try again");
      return;
    }
    await updateShopOrders();
  }

  Future<void> updateShopOrders() async {
    try {
      orders.value = await getShopOrders();
    } on HTTPException catch (err) {
      Get.snackbar("Cannot get shop order", err.response.body);
    }
  }

  Future<List<Order>> getShopOrders() async {
    final response = await Requests.get(
      '${Config.getServerUrl()}/api/v1/shops/${authController.shopId.value}/orders',
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

    return orders;
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
    } on HTTPException catch (err) {
      Get.snackbar("Cannot cancel order", err.response.body);
    }
  }

  Future<void> readyOrder(int index) async {
    try {
      final response = await Requests.patch(
        '${Config.getServerUrl()}/api/v1/shops/${orders[index].shopId}/orders/${orders[index].id}/ready',
        headers: {
          'Content-Type': 'application/json',
        },
      );
      response.raiseForStatus();

      orders[index].status = response.json()["status"];
      orders.refresh();
    } on HTTPException catch (err) {
      Get.snackbar("Cannot ready order", err.response.body);
    }
  }

  Future<void> completeOrder(int index) async {
    try {
      final response = await Requests.patch(
        '${Config.getServerUrl()}/api/v1/shops/${orders[index].shopId}/orders/${orders[index].id}/complete',
        headers: {
          'Content-Type': 'application/json',
        },
      );
      response.raiseForStatus();

      orders[index].status = response.json()["status"];
      orders.refresh();
    } on HTTPException catch (err) {
      Get.snackbar("Cannot complete order", err.response.body);
    }
  }
}
