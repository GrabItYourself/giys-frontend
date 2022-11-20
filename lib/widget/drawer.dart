import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/config/config.dart';
import 'package:giys_frontend/config/route.dart';
import 'package:giys_frontend/controllers/drawer.dart';

class _RouteConfig {
  String label;
  String path;
  Icon icon;
  _RouteConfig(this.label, this.path, this.icon);
}

class MainDrawer extends StatelessWidget {
  final drawerController = Get.put(MainDrawerController());

  final _routeConfigs = [
    _RouteConfig("Home", RoutePath.defaultPath, const Icon(Icons.home)),
    _RouteConfig("Shops", RoutePath.allShopPath, const Icon(Icons.food_bank)),
    _RouteConfig("Orders", RoutePath.ordersPath, const Icon(Icons.list)),
    _RouteConfig("Payment Method", RoutePath.paymentMethodPath,
        const Icon(Icons.payment)),
    _RouteConfig(
        "Settings", RoutePath.settingsPath, const Icon(Icons.settings)),
  ];

  _onListItemTab(String path) {
    drawerController.closeDrawer();
    Get.offAndToNamed(path);
  }

  MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.white12,
            ),
            child: Center(
              child: Text(
                Config.getAppName(),
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
          ),
          for (var item in _routeConfigs)
            ListTile(
              leading: item.icon,
              title: Text(item.label),
              onTap: () => _onListItemTab(item.path),
            ),
        ],
      ),
    );
  }
}
