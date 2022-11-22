import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/config/route.dart';
import 'package:giys_frontend/controllers/shop_manage.dart';
import 'package:giys_frontend/widget/shop.dart';

import '../widget/scaffold.dart';

class ShopManageView extends StatelessWidget {
  final shopListController = Get.find<ShopManageController>();

  ShopManageView({super.key});

  Future<void> _refresh() async {
    await shopListController.getShopList();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: 'Manage Shops',
      back: true,
      body: SingleChildScrollView(
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      "Shop List",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Get.toNamed(RoutePath.shopCreatePath),
                      icon: const Icon(Icons.add),
                    ),
                    IconButton(
                      onPressed: () => shopListController.getShopList(),
                      icon: const Icon(Icons.refresh),
                    ),
                  ],
                ),
                Obx(() => shopListController.shopList.isEmpty
                    ? const Center(child: Text('No shop'))
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: shopListController.shopList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final shop = shopListController.shopList[index];
                          return ShopWidget(
                            shop: shop,
                            onDelete: () =>
                                shopListController.deleteShop(shop.id),
                          );
                        },
                      ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
