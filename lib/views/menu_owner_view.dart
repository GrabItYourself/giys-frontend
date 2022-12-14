import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/config/route.dart';
import 'package:giys_frontend/controllers/auth.dart';
import 'package:giys_frontend/controllers/my_menu.dart';
import 'package:giys_frontend/widget/shop/shop_menu_item.dart';

class MenuOwnerView extends StatelessWidget {
  final myMenuController = Get.put(MyMenuController());
  final AuthController authController = Get.find<AuthController>();

  MenuOwnerView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: myMenuController
          .setShopId(int.parse(authController.shopId.toString())),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("My Shop Menu"),
            actions: [
              Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () => Get.toNamed(
                        RoutePath.editMenuPath.replaceAll(
                            ':shopId', authController.shopId.toString()),
                        arguments: [
                          authController.shopId.value,
                          null,
                          "CREATE"
                        ]),
                    child: const Icon(Icons.add),
                  ))
            ],
          ),
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () => myMenuController
                  .getAllShopItems(int.parse(authController.shopId.toString())),
              child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Obx(() => ListView.builder(
                              itemCount: myMenuController.menuList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ShopMenuItem(
                                  name: myMenuController.menuList[index].name,
                                  price: myMenuController.menuList[index].price,
                                  image: myMenuController.menuList[index].image,
                                  shopId: authController.shopId.value as int,
                                  shopItem: myMenuController.menuList[index],
                                );
                              },
                            )),
                      ),
                    ],
                  )),
            ),
          ),
        );
      },
    );
  }
}
