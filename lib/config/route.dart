class RoutePath {
  static const defaultPath = '/';
  static const homePath = '/home';
  static const loginPath = '/login';
  static const paymentPath = '/payment';
  static const allShopPath = '/shops';
  static const shopMenuPath = '/shops/:shopId/menu';
  static const shopDetailPath = '/shops/:shopId';
  static const shopOwnerPath = '/my-shop';
  static const shopOwnerMenuPath = '$shopOwnerPath/menu';
  static const editShopPath = '/edit/shop/:shopId';
  static const editMenuPath = '/edit/shop/:shopId/item/:shopItemId';
  static const settingsPath = '/settings';

  static const shopManagePath = '/shop/manage';
  static const shopCreatePath = '/shop/create';

  static const paymentMethodPath = '/paymentMethods';
  static const addPaymentMethodPath = '/paymentMethods/add';
}
