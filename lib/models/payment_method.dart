class PaymentMethod {
  int id;
  String lastFourDigits;
  bool isDefault;

  PaymentMethod({
    required this.id,
    required this.lastFourDigits,
    required this.isDefault,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      id: json['id'],
      lastFourDigits: json['last_four_digits'],
      isDefault: json['is_default'] ?? false,
    );
  }
}

class AddPaymentMethodRequest {
  String cardNumber;
  String name;
  String cvv;
  int expirationMonth;
  int expirationYear;

  AddPaymentMethodRequest({
    required this.cardNumber,
    required this.name,
    required this.cvv,
    required this.expirationMonth,
    required this.expirationYear,
  });
}
