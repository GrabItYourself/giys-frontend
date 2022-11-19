import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/config/route.dart';
import 'package:giys_frontend/controllers/auth.dart';
import 'package:giys_frontend/controllers/my_menu.dart';
import 'package:giys_frontend/widget/shop/shop_menu_item.dart';

class MenuOwnerView extends StatelessWidget {
  final myMenuController = Get.put(MyMenuController());
  final shopId = Get.arguments;
  final AuthController authController = Get.find<AuthController>();

  MenuOwnerView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: myMenuController.setShopId(int.parse(authController.id.value)),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("My Shop Menu"),
            actions: [
              Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: null,
                    child: const Icon(Icons.add),
                  ))
            ],
          ),
          body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      //TODO add add/edit/delete capabilities
                      child: Obx(() => ListView.builder(
                            itemCount: myMenuController.menuList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                children: [
                                  ShopMenuItem(
                                      name:
                                          myMenuController.menuList[index].name,
                                      price: myMenuController
                                          .menuList[index].price,
                                      image: myMenuController
                                          .menuList[index].image),
                                  IconButton(
                                      onPressed: () => Get.toNamed(
                                              RoutePath.editMenuPath
                                                  .replaceAll(':shopId',
                                                      shopId.toString())
                                                  .replaceAll(
                                                      ":shopItemId",
                                                      myMenuController
                                                          .menuList[index].id
                                                          .toString()),
                                              arguments: [
                                                shopId,
                                                myMenuController
                                                    .menuList[index],
                                                "EDIT"
                                              ]),
                                      icon: const Icon(Icons.edit))
                                ],
                              );
                            },
                          )),
                    ),
                    TextButton(
                        onPressed: () => Get.toNamed(
                            RoutePath.editMenuPath
                                .replaceAll(':shopId', shopId.toString()),
                            arguments: [shopId, null, "CREATE"]),
                        child: const Text("Add new item")),
                  ],
                )),
          ),
        );
      },
    );
  }
}
