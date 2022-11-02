class Shop {
  int id;
  String name;
  String? image;
  String? desc;
  String? location;
  String? contact;

  Shop({
    required this.id,
    required this.name,
    this.image,
    this.desc,
    this.location,
    this.contact,
  });
}
