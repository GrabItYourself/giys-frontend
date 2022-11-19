import 'package:get/get.dart';
import 'package:giys_frontend/config/route.dart';
import 'package:giys_frontend/controllers/auth.dart';
import 'package:requests/requests.dart';

import '../config/config.dart';
import '../models/shop.dart';

class MyShopController extends GetxController {
  final shop = Shop(id: 0, name: '').obs;
  final AuthController authController = Get.find<AuthController>();

  @override
  void onInit() async {
    super.onInit();
    try {
      final shopData = await getMyShop(int.parse(authController.id.value!));
      shop.value = Shop(
          id: shopData.shop.id,
          name: shopData.shop.name,
          image: shopData.shop.image,
          description: shopData.shop.description,
          location: shopData.shop.location,
          contact: shopData.shop.contact);
    } catch (err) {
      return Future.error(err);
    }
  }

  // TODO get shop id from user credentials
  Future<ShopResponse> getMyShop(int id) async {
    final response = await Requests.get(
      '${Config.getServerUrl()}/api/v1/shops/$id',
      headers: {
        'Content-Type': 'application/json',
      },
    );
    response.raiseForStatus();
    return ShopResponse.fromJson(response.json());
  }

  // TODO get shop id from user credentials
  updateShop(int id) async {
    try {
      final shopData = await getMyShop(id);
      shop.value = Shop(
          id: shopData.shop.id,
          name: shopData.shop.name,
          image: shopData.shop.image,
          description: shopData.shop.description,
          location: shopData.shop.location,
          contact: shopData.shop.contact);
    } catch (err) {
      return Future.error(err);
    }
  }
}
