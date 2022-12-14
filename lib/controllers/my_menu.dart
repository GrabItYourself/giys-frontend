import 'package:get/get.dart';
import 'package:giys_frontend/models/shop_item.dart';
import 'package:requests/requests.dart';

import '../config/config.dart';
import '../config/route.dart';

class MyMenuController extends GetxController {
  final menuList = <ShopItem>[].obs;

  // @override
  // void onInit() async {
  //   super.onInit();
  //   try {
  //     final shopItemsData = await getAllShopItems(1);
  //     for (var i = 0; i < shopItemsData.items.length; i++) {
  //       menuList.add(ShopItem(
  //           id: shopItemsData.items[i].id,
  //           shopId: shopItemsData.items[i].shopId,
  //           name: shopItemsData.items[i].name,
  //           price: shopItemsData.items[i].price));
  //     }
  //   } catch (err) {
  //     Get.snackbar("Cannot get shop menu", err.toString());
  //     return Future.error(err);
  //   }
  // }

  Future<AllShopItemsResponse> getAllShopItems(int shopId) async {
    final response = await Requests.get(
      '${Config.getServerUrl()}/api/v1/shops/$shopId/items',
      headers: {
        'Content-Type': 'application/json',
      },
    );
    response.raiseForStatus();
    print(response.json());
    return AllShopItemsResponse.fromJson(response.json());
  }

  setShopId(int shopId) async {
    menuList.clear();
    try {
      final shopItemsData = await getAllShopItems(shopId);
      for (var i = 0; i < shopItemsData.items.length; i++) {
        menuList.add(ShopItem(
            id: shopItemsData.items[i].id,
            shopId: shopItemsData.items[i].shopId,
            name: shopItemsData.items[i].name,
            image: shopItemsData.items[i].image,
            price: shopItemsData.items[i].price));
      }
    } catch (err) {
      print(err);
      Get.snackbar("Cannot get shop menu", err.toString());
      return Future.error(err);
    }

    addItem(ShopItem item) async {
      const shopId = 1;
      final response = await Requests.post(
          '${Config.getServerUrl()}/api/v1/shops/$shopId/items',
          body: {
            'id': item.id,
            'shopId': item.shopId,
            'name': item.name,
            'price': item.price,
            'image': item.image
          },
          bodyEncoding: RequestBodyEncoding.FormURLEncoded);
      response.raiseForStatus();
      menuList.add(item);
    }

    removeItem(int itemId) async {
      const shopId = 1;
      final response = await Requests.delete(
          '${Config.getServerUrl()}/api/v1/shops/$shopId/items/$itemId');
      response.raiseForStatus();
      menuList.removeWhere((item) => item.id == itemId);
    }

    updateItem(int itemId) async {
      const shopId = 1;
    }
  }
}
