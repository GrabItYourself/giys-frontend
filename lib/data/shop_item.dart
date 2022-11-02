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
}
