class ShopItem {
  final int id;
  final int shopId;
  final String name;
  final int price;
  final String? image;

  ShopItem(
      {required this.id,
      required this.shopId,
      required this.name,
      required this.price,
      this.image});

  factory ShopItem.fromJson(Map<String, dynamic> json) {
    return ShopItem(
        id: json['id'],
        shopId: json['shop_id'],
        name: json['name'],
        price: json['price'],
        image: json['image']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['id'] = id;
    json['shop_id'] = shopId;
    json['name'] = name;
    json['price'] = price;
    json['image'] = image;
    return json;
  }
}

class ShopItemResponse {
  final ShopItem item;

  ShopItemResponse({required this.item});

  factory ShopItemResponse.fromJson(Map<String, dynamic> json) {
    return ShopItemResponse(item: ShopItem.fromJson(json['item']));
  }
}

class AllShopItemsResponse {
  final List<ShopItem> items;

  AllShopItemsResponse({required this.items});

  factory AllShopItemsResponse.fromJson(Map<String, dynamic> json) {
    List<ShopItem> itemsFromJson = [];
    for (var shopItemJson in json['shops']) {
      itemsFromJson.add(ShopItem.fromJson(shopItemJson));
    }
    return AllShopItemsResponse(items: itemsFromJson);
  }
}
