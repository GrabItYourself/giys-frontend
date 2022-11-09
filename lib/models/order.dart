class Order {
  int id;
  String userId;
  int shopId;
  String status;
  List<OrderItem> items;

  //TODO: add shop

  Order({
    required this.id,
    required this.userId,
    required this.shopId,
    required this.status,
    required this.items,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    final items = json['items'].map((item) => OrderItem.fromJson(item));
    return Order(
      id: json['id'],
      userId: json['user_id'],
      shopId: json['shop_id'],
      status: json['status'],
      items: items,
    );
  }
}

class OrderItem {
  int shopItemId;
  int quantity;
  String note;

  //TODO: add shop item

  OrderItem({
    required this.shopItemId,
    required this.quantity,
    required this.note,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      shopItemId: json['shop_item_id'],
      quantity: json['quantity'],
      note: json['note'],
    );
  }
}
