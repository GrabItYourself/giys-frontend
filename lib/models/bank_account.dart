class BankAccount {
  String name;
  String number;
  String type;
  String brand;

  BankAccount({
    required this.name,
    required this.number,
    required this.type,
    required this.brand,
  });

  factory BankAccount.fromJson(Map<String, dynamic> json) {
    return BankAccount(
      name: json['name'],
      number: json['number'],
      type: json['type'],
      brand: json['brand'],
    );
  }
}
