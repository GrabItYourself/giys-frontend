import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:giys_frontend/data/shop.dart';
import 'package:giys_frontend/screens/home/shop_menu_view.dart';
import 'package:http/http.dart' as http;

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  //TODO complete this function
  Future<List<Shop>> getAllShop() async {
    List<Shop> allShop = [];
    String token = await getToken();
    final response = await http.get(
      Uri.http("localhost:8080", "/api/v1/shops"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
    );
    log(response.toString());
    for (var shop in jsonDecode(response.body)) {
      allShop.add(Shop.fromJson(shop));
    }
    return allShop;
  }

  late final List<Shop> shopList;
  @override
  void initState() {
    // TODO: implement get shopList
    getAllShop().then(
      (value) {
        shopList = value;
      },
    );
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
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ShopMenuView(shop: shop),
                  ));
                },
              );
            },
          ),
        )
      ]),
    );
  }
}
