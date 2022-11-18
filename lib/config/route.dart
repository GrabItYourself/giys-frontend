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
  static const ordersPath = '/orders';
  static const shopOrdersPath = '/my-shop/orders';
  static const orderDetailPath = '/orders/details';

  static const shopManagePath = '/shop/manage';
  static const shopCreatePath = '/shop/create';
  static const shopManageEditPath = '/shop/manage/:shopId';

  static const paymentMethodPath = '/paymentMethods';
  static const addPaymentMethodPath = '/paymentMethods/add';

  static toPath(String name, Map<String, String> data) {
    var path = name;
    var hasQueryParams = false;
    for (var key in data.keys) {
      if (path.contains(':$key')) {
        path = path.replaceAll(':$key', data[key]!);
      } else {
        if (hasQueryParams == false) {
          path += '?';
          hasQueryParams = true;
        } else {
          path += '&';
        }
        path += '$key=${data[key]}';
      }
    }
    return path;
  }
}
