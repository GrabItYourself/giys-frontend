class RoutePath {
  static const defaultPath = '/';
  static const homePath = '/home';
  static const loginPath = '/login';
  static const paymentPath = '/payment';
  static const shopOwnerPath = '/my-shop';
  static const shopOwnerMenuPath = '$shopOwnerPath/menu';
  static const editShopPath = '/edit/shop/:shopId';
  static const editMenuPath = '/edit/shop/:shopId/item/:shopItemId';
  static const settingsPath = '/settings';
  static const ordersPath = '/orders';
  static const shopOrdersPath = '/my-shop/orders';
  static const orderDetailPath = '/shops/:shopId/orders/:orderId';

  static const shopManagePath = '/shop/manage';
  static const shopCreatePath = '/shop/create';

  static const paymentMethodPath = '/paymentMethods';
  static const addPaymentMethodPath = '/paymentMethods/add';
}
