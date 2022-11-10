class RoutePath {
  static const defaultPath = '/';
  static const homePath = '/home';
  static const loginPath = '/login';
  static const paymentPath = '/payment';
  static const allShopPath = '/shops';
  static const shopMenuPath = '/shop-menu';
  static const shopDetailPath = '/shop-detail';
  static const shopOwnerPath = '/my-shop';
  static const shopOwnerMenuPath = '$shopOwnerPath/menu';
  static const editShopPath = '/edit/shop/:shopId';
  static const editMenuPath = '/edit/shop/:shopId/item/:shopItemId';
  static const settingsPath = '/settings';

  static const manageShopPath = '/shop/manage';
  static const createShopPath = '/shop/create';

  static const protectedPaths = [
    paymentPath,
    settingsPath,
    // manageShopPath,
    // createShopPath
  ];
}
