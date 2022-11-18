class BankAccount {
  String name;
  String number;
  String type;
  String bank;

  BankAccount({
    required this.name,
    required this.number,
    required this.type,
    required this.bank,
  });

  factory BankAccount.fromJson(Map<String, dynamic> json) {
    return BankAccount(
      name: json['name'],
      number: json['number'],
      type: json['type'],
      bank: json['bank'],
    );
  }
}
