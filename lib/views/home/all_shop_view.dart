import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/controllers/auth.dart';
import 'package:giys_frontend/models/shop.dart';
import 'package:giys_frontend/views/home/shop_menu_view.dart';
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

  late final List<Shop> shopList;
  @override
  void initState() {
    // TODO: implement get shopList
    getAllShop().then((value) {
      shopList = value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("debug"),
      ),
      body: TextButton(
          onPressed: () async {
            shopList = await getAllShop();
            log(shopList.toString());
          },
          child: const Text("Send HTTP request")),
    );
  }
}
