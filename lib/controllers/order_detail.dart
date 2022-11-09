import 'package:get/get.dart';
import 'package:giys_frontend/models/order.dart';

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

  Future<int> getShop(int shopId) async {
    await Future.delayed(const Duration(seconds: 1));
    return shopId;
  }

  Future<Order> getOrder(int shopId, int orderId) async {
    await Future.delayed(const Duration(seconds: 1));
    return Order(
      id: orderId,
      userId: '',
      shopId: shopId,
      status: '',
      items: <OrderItem>[
        OrderItem(orderId: 1, shopId: 1, shopItemId: 1, quantity: 10, note: ''),
        OrderItem(
          orderId: 1,
          shopId: 1,
          shopItemId: 2222222222,
          quantity: 20,
          note: 'helelelelejlelelelel',
        ),
        OrderItem(orderId: 1, shopId: 1, shopItemId: 3, quantity: 30, note: ''),
        OrderItem(orderId: 1, shopId: 1, shopItemId: 4, quantity: 40, note: ''),
        OrderItem(orderId: 1, shopId: 1, shopItemId: 5, quantity: 50, note: ''),
      ],
    );
  }

  Future<String> getShopItem(int shopId, int shopItemId) async {
    await Future.delayed(const Duration(seconds: 1));
    return 'shopItem $shopId $shopItemId';
  }
}
