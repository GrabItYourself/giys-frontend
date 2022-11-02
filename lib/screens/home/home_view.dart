import 'package:flutter/material.dart';
import 'package:giys_frontend/data/shop.dart';
import 'package:giys_frontend/screens/home/shop_menu_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final List<Shop> shopList;
  @override
  void initState() {
    // TODO: implement get shopList
    shopList = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Column(children: [
        ListView.builder(
          itemBuilder: (context, index) {
            final shop = shopList[index];
            return ListTile(
              leading: Image.network(shop.image ?? ""),
              title: Text(shop.name),
              subtitle: Text(shop.desc ?? ""),
              onTap: () {
                MaterialPageRoute(
                  builder: (context) => ShopMenuView(shop: shop),
                );
              },
            );
          },
        ),
      ]),
    );
  }
}
