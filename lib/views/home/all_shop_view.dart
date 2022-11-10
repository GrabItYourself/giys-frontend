import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/config/route.dart';
import 'package:giys_frontend/controllers/auth.dart';
import 'package:giys_frontend/models/shop.dart';
import 'package:giys_frontend/views/home/shop_menu_view.dart';
import 'package:http/http.dart' as http;

class AllShopView extends StatefulWidget {
  const AllShopView({super.key});

  @override
  State<AllShopView> createState() => _AllShopViewState();
}

class _AllShopViewState extends State<AllShopView> {
  //TODO complete this function
  Future<List<Shop>> getAllShop() async {
    List<Shop> allShop = [];
    final response = await http.get(
      Uri.https("localhost:8080", "/api/v1/shops"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    log(response.toString());
    for (var shop in jsonDecode(response.body)) {
      allShop.add(Shop.fromJson(shop));
    }
    return allShop;
  }

  late final List<Shop> shopList = [
    Shop(
        id: 1,
        name: "shop1",
        contact: "none",
        description: "desc",
        location: "asdasdasd"),
    Shop(id: 2, name: "shop2"),
  ];
  @override
  void initState() {
    // TODO: implement get shopList
    // getAllShop().then((value) {
    //   shopList = value;
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Column(children: [
        Expanded(
          child: ListView.builder(
            itemCount: shopList.length,
            itemBuilder: (context, index) {
              final shop = shopList[index];
              return ListTile(
                leading: shop.image != null
                    ? Image.network(
                        shop.image!,
                        fit: BoxFit.fitWidth,
                      )
                    : Image.network(
                        "https://picsum.photos/200",
                        fit: BoxFit.fitWidth,
                      ),
                title: Text(shop.name),
                subtitle: Text(shop.description ?? ""),
                onTap: () {
                  Get.toNamed(RoutePath.shopMenuPath, arguments: shop);
                },
              );
            },
          ),
        )
      ]),
    );
  }
}
