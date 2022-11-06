class ShopItem {
  int id;
  int shopId;
  String name;
  String? image;
  int price;

  ShopItem({
    required this.id,
    required this.shopId,
    required this.name,
    this.image,
    required this.price,
  });

  factory ShopItem.fromJson(Map<String, dynamic> json) {
    return ShopItem(
      id: json["id"],
      shopId: json["shop_id"],
      name: json["name"],
      price: json["price"],
      image: json["image"],
    );
  }
}
