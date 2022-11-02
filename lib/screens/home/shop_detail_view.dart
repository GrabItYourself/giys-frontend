import 'package:flutter/material.dart';
import 'package:giys_frontend/data/shop.dart';

class ShopDetailView extends StatefulWidget {
  final Shop shop;
  const ShopDetailView({super.key, required this.shop});

  @override
  State<ShopDetailView> createState() => _ShopDetailViewState();
}

class _ShopDetailViewState extends State<ShopDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Shop Detail")),
      body: Column(
        children: [
          Image.network(
            widget.shop.image ?? "",
            fit: BoxFit.fitWidth,
          ),
          Text(widget.shop.name),
          Text(widget.shop.desc ?? ""),
          Text(widget.shop.location ?? ""),
          Text(widget.shop.contact ?? ""),
        ],
      ),
    );
  }
}
