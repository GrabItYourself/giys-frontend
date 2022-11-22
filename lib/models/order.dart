import 'package:giys_frontend/models/shop.dart';
import 'package:giys_frontend/models/shop_item.dart';

class Order {
  int id;
  String userId;
  int shopId;
  String status;
  List<OrderItem> items;

  Shop? shop;
  Transaction? transaction;

  Order({
    required this.id,
    required this.userId,
    required this.shopId,
    required this.status,
    required this.items,
    this.shop,
    this.transaction,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    final items = (json['items'] as List)
        .map((item) => OrderItem.fromJson(item))
        .toList();

    Transaction? transaction;
    if (json['payment_transaction'] != null) {
      transaction = Transaction.fromJson(json['payment_transaction']);
    } else {
      transaction = null;
    }

    return Order(
      id: json['order_id'],
      userId: json['user_id'],
      shopId: json['shop_id'],
      status: json['status'],
      items: items,
      shop: Shop.fromJson(json['shop']),
      transaction: transaction,
    );
  }
}

class OrderItem {
  int shopItemId;
  int quantity;
  String? note;
  ShopItem? shopItem;

  OrderItem({
    required this.shopItemId,
    required this.quantity,
    required this.note,
    this.shopItem,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      shopItemId: json['shop_item_id'],
      quantity: json['quantity'],
      note: json['note'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['shop_item_id'] = shopItemId;
    json['quantity'] = quantity;
    json['note'] = note;
    return json;
  }
}

class Transaction {
  int amount;
  int createdAt;

  Transaction({
    required this.amount,
    required this.createdAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      amount: json['amount'],
      createdAt: json['created_at'],
    );
  }
}
