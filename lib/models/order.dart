class Order {
  int id;
  String userId;
  int shopId;
  String status;
  List<OrderItem> items;

  Order({
    required this.id,
    required this.userId,
    required this.shopId,
    required this.status,
    required this.items,
  });
}

class OrderItem {
  int orderId;
  int shopId;
  int shopItemId;
  int quantity;
  String note;

  OrderItem({
    required this.orderId,
    required this.shopId,
    required this.shopItemId,
    required this.quantity,
    required this.note,
  });
}
