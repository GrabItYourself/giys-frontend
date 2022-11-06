class Shop {
  int id;
  String name;
  String? image;
  String? description;
  String? location;
  String? contact;

  Shop({
    required this.id,
    required this.name,
    this.image,
    this.description,
    this.location,
    this.contact,
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      description: json['description'],
      location: json['loc'],
      contact: json['contact'],
    );
  }
}
