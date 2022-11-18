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
    _RouteConfig(
        "All Shops", RoutePath.allShopPath, const Icon(Icons.safety_check)),
    _RouteConfig("Shop", RoutePath.defaultPath, const Icon(Icons.shop)),
    _RouteConfig("Order", RoutePath.ordersPath,
        const Icon(Icons.toc)), // TODO: find icons
    _RouteConfig("Setting", RoutePath.settingsPath, const Icon(Icons.settings)),
    _RouteConfig("Login", RoutePath.loginPath, const Icon(Icons.login))
  ];

  _onListItemTab(String path) {
    drawerController.closeDrawer();
    Get.toNamed(path);
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
