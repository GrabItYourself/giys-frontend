import 'package:flutter/material.dart';
import 'package:giys_frontend/data/shop.dart';
import 'package:giys_frontend/screens/settings/show_detail_owner_edit_view.dart';

class ShopDetailOwnerView extends StatefulWidget {
  const ShopDetailOwnerView({super.key});

  @override
  State<ShopDetailOwnerView> createState() => _ShopDetailOwnerViewState();
}

class _ShopDetailOwnerViewState extends State<ShopDetailOwnerView> {
  //TODO get current user from existing backend
  late final Shop userShop;
  @override
  void initState() {
    //get user shop from user id
    userShop = Shop(
      id: 23,
      name: "Name",
      contact: "Contact",
      desc: "desc",
      image: null,
      location: "loc",
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Shop Details")),
      body: Column(
        children: [
          Image.network(
            userShop.image ?? "",
            fit: BoxFit.fitWidth,
          ),
          Text(userShop.name),
          Text(userShop.desc ?? ""),
          Text(userShop.location ?? ""),
          Text(userShop.contact ?? ""),
          //TODO find out where bankAccount is
          Text("Bank Account"),
          Wrap(
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ShopDetailOwnerEditView()));
                  },
                  child: const Text("Edit Details")),
              TextButton(onPressed: () {}, child: const Text("Edit Menu")),
            ],
          ),
        ],
      ),
    );
  }
}
