import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/config/route.dart';
import 'package:giys_frontend/controllers/my_shop.dart';

class ShopOwnerView extends StatelessWidget {
  final myShopController = Get.put(MyShopController());

  ShopOwnerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Shop")),
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: GetX<MyShopController>(builder: (controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Image.network(
                        controller.shop.value.image ??
                            "https://picsum.photos/seed/picsum/200",
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Shop Name",
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.3))),
                        Text(controller.shop.value.name),
                        const SizedBox(
                          height: 8,
                        ),
                        Text("Description",
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.3))),
                        Text(controller.shop.value.description ?? ""),
                        const SizedBox(
                          height: 8,
                        ),
                        Text("Location",
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.3))),
                        Text(controller.shop.value.location ?? ""),
                        const SizedBox(
                          height: 8,
                        ),
                        Text("Contact",
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.3))),
                        Text(controller.shop.value.contact ?? ""),
                      ],
                    )),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                              onPressed: () => Get.toNamed(
                                  RoutePath.editShopPath.replaceAll(':shopId',
                                      controller.shop.value.id.toString())),
                              icon: const Icon(Icons.edit),
                              label: const Text("Edit Details")),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                            child: OutlinedButton.icon(
                                onPressed: () =>
                                    Get.toNamed(RoutePath.shopOwnerMenuPath),
                                icon: const Icon(Icons.food_bank),
                                label: const Text("Edit Menu")))
                      ],
                    )
                  ],
                );
              }))),
    );
  }
}
