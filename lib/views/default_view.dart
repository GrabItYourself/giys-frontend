import 'package:flutter/material.dart';
import 'package:giys_frontend/views/settings/settings_view.dart';
import 'package:giys_frontend/views/shop_orders_view.dart';

import 'home/all_shop_view.dart';
import 'orders_view.dart';

class DefaultView extends StatefulWidget {
  final _tab1navigatorKey = GlobalKey<NavigatorState>();
  final _tab2navigatorKey = GlobalKey<NavigatorState>();
  final _tab3navigatorKey = GlobalKey<NavigatorState>();
  final _tab4navigatorKey = GlobalKey<NavigatorState>();

  /// pass the required items for the tabs and BottomNavigationBar
  late final List<PersistentTabItem> items = [
    PersistentTabItem(
        tab: AllShopView(),
        title: "Home",
        icon: Icons.home,
        navigatorkey: _tab1navigatorKey),
    PersistentTabItem(
        tab: const OrdersView(),
        title: "Orders",
        icon: Icons.shop,
        navigatorkey: _tab2navigatorKey),
    PersistentTabItem(
        tab: const ShopOrdersView(),
        title: "Shop Orders",
        icon: Icons.shop_2,
        navigatorkey: _tab3navigatorKey),
    PersistentTabItem(
        tab: const SettingsView(),
        title: "Settings",
        icon: Icons.settings,
        navigatorkey: _tab4navigatorKey),
  ];

  DefaultView({super.key});

  @override
  _DefaultViewState createState() => _DefaultViewState();
}

class _DefaultViewState extends State<DefaultView> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        /// Check if curent tab can be popped
        if (widget.items[_selectedTab].navigatorkey?.currentState?.canPop() ??
            false) {
          widget.items[_selectedTab].navigatorkey?.currentState?.pop();
          return false;
        } else {
          // if current tab can't be popped then use the root navigator
          return true;
        }
      },
      child: Scaffold(
        /// Using indexedStack to maintain the order of the tabs and the state of the
        /// previously opened tab
        body: IndexedStack(
          index: _selectedTab,
          children: widget.items
              .map((page) => Navigator(
                    /// Each tab is wrapped in a Navigator so that navigation in
                    /// one tab can be independent of the other tabs
                    key: page.navigatorkey,
                    onGenerateInitialRoutes: (navigator, initialRoute) {
                      return [
                        MaterialPageRoute(builder: (context) => page.tab)
                      ];
                    },
                  ))
              .toList(),
        ),

        /// Define the persistent bottom bar
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedTab,
          onTap: (index) {
            if (index == _selectedTab) {
              widget.items[index].navigatorkey?.currentState
                  ?.popUntil((route) => route.isFirst);
            } else {
              setState(() {
                _selectedTab = index;
              });
            }
          },
          items: widget.items
              .map((item) => BottomNavigationBarItem(
                  icon: Icon(item.icon), label: item.title))
              .toList(),
          type: BottomNavigationBarType.fixed, // Fixed
          backgroundColor: Colors.black, // <-- This works for fixed
          selectedItemColor: Colors.greenAccent,
          unselectedItemColor: Colors.grey,
        ),
      ),
    );
  }
}

class PersistentTabItem {
  final Widget tab;
  final GlobalKey<NavigatorState>? navigatorkey;
  final String title;
  final IconData icon;

  PersistentTabItem(
      {required this.tab,
      this.navigatorkey,
      required this.title,
      required this.icon});
}
