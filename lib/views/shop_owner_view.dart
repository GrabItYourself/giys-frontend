import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/config/route.dart';

class ShopOwnerView extends StatelessWidget {
  const ShopOwnerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Shop")),
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Image.network(
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
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.3))),
                      const Text("ข้าวแกงป้าลี"),
                      const SizedBox(
                        height: 8,
                      ),
                      Text("Description",
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.3))),
                      const Text(
                          "ปาสกาลกาญจน์ไทเฮา เจลตอกย้ำเลกเชอร์ทัวร์นาเมนท์เซนเซอร์ ชีสโซนี่คอนแทคศิลปวัฒนธรรม ปาร์ตี้สงบสุข เฉิ่มฟีเวอร์ดีกรีอะบอดี้"),
                      const SizedBox(
                        height: 8,
                      ),
                      Text("Location",
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.3))),
                      const Text("iCanteen"),
                      const SizedBox(
                        height: 8,
                      ),
                      Text("Contact",
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.3))),
                      const Text("อย่าติดต่อมา"),
                    ],
                  )),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                            onPressed: () =>
                                Get.toNamed(RoutePath.editShopPath),
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
              ))),
    );
  }
}
