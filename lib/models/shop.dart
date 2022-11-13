import 'user.dart';

class Shop {
  final int id;
  final String name;
  final String? image;
  final String? description;
  final String? location;
  final String? contact;
  final List<User>? owners;

  Shop({
    required this.id,
    required this.name,
    this.image,
    this.description,
    this.location,
    this.contact,
    this.owners,
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      description: json['description'],
      location: json['location'],
      contact: json['contact'],
      owners: json['owners'] != null
          ? (json['owners'] as List).map((e) => User.fromJson(e)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['id'] = id;
    json['name'] = name;
    json['image'] = image;
    json['description'] = description;
    json['location'] = location;
    json['contact'] = contact;
    if (owners != null) {
      json['owners'] = owners?.map((v) => v.toJson()).toList();
    }
    return json;
  }
}

class ShopResponse {
  final Shop shop;

  ShopResponse({required this.shop});

  factory ShopResponse.fromJson(Map<String, dynamic> json) {
    return ShopResponse(shop: Shop.fromJson(json['shop']));
  }
}

class AllShopsResponse {
  final List<Shop> shops;

  AllShopsResponse({required this.shops});

  factory AllShopsResponse.fromJson(Map<String, dynamic> json) {
    List<Shop> shopsFromJson = [];
    for (var shopJson in json['shops']) {
      shopsFromJson.add(Shop.fromJson(shopJson));
    }
    return AllShopsResponse(shops: shopsFromJson);
  }
}

class DeleteResponse {
  final int rowsAffected;

  DeleteResponse({required this.rowsAffected});

  factory DeleteResponse.fromJson(Map<String, dynamic> json) {
    return DeleteResponse(rowsAffected: json['rowsAffected']);
  }
}
