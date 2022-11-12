import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/config/route.dart';
import 'package:giys_frontend/controllers/shop_manage.dart';
import 'package:giys_frontend/widget/shop.dart';

import '../widget/scaffold.dart';

class ShopManageView extends StatefulWidget {
  const ShopManageView({super.key});

  @override
  State<ShopManageView> createState() => _ShopManageViewState();
}

class _ShopManageViewState extends State<ShopManageView> {
  final shopListController = Get.find<ShopManageController>();

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    await shopListController.getShopList();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: 'Manage Shops',
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
                _ShopListView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ShopListView extends StatelessWidget {
  final shopListController = Get.find<ShopManageController>();

  _ShopListView({super.key});

  @override
  Widget build(BuildContext context) {
    if (shopListController.shopList.isEmpty) {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: const Text("No Shop"),
      );
    }

    return Obx(() => ListView(
          shrinkWrap: true,
          children: shopListController.shopList
              .map(
                (shop) => ShopWidget(
                  shop: shop,
                ),
              )
              .toList(),
        ));
  }
}
