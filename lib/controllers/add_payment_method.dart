import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/models/payment_method.dart';

class AddPaymentMethodController extends GetxController {
  String cardNumber = '';
  final cardNumberController = TextEditingController();
  final cardNumberErrorText = Rx<String?>(null);

  String name = '';
  final nameController = TextEditingController();
  final nameErrorText = Rx<String?>(null);

  String cvv = '';
  final cvvController = TextEditingController();
  final cvvErrorText = Rx<String?>(null);

  int expirationMonth = 0;
  int expirationYear = 0;
  final expirationDateController = TextEditingController();
  final expirationDateErrorText = Rx<String?>(null);

  bool validate() {
    var valid = true;

    cardNumber = cardNumberController.text.replaceAll(" ", "");
    if (cardNumber.isEmpty || cardNumber.length != 16) {
      cardNumberErrorText.value = 'Please enter valid card number';
      valid = false;
    } else {
      cardNumberErrorText.value = null;
    }

    name = nameController.text;
    if (name.isEmpty) {
      nameErrorText.value = 'Please enter valid name';
      valid = false;
    } else {
      nameErrorText.value = null;
    }

    cvv = cvvController.text;
    if (cvv.isEmpty || cvv.length < 3) {
      cvvErrorText.value = 'Please enter valid cvv';
      valid = false;
    } else {
      cvvErrorText.value = null;
    }

    final expirationDateStr = expirationDateController.text;
    if (expirationDateStr.length < 5) {
      expirationDateErrorText.value = 'Please enter valid date';
      valid = false;
    } else {
      expirationMonth = int.parse(expirationDateStr.substring(0, 2));
      expirationYear = int.parse(expirationDateStr.substring(3, 5)) + 2000;

      if (expirationMonth <= 0 || expirationMonth > 12) {
        expirationDateErrorText.value = 'Please enter valid date';
        valid = false;
      } else {
        expirationDateErrorText.value = null;
      }
    }

    return valid;
  }

  AddPaymentMethodRequest createAddPaymentMethodRequest() {
    return AddPaymentMethodRequest(
      cardNumber: cardNumber,
      name: name,
      cvv: cvv,
      expirationMonth: expirationMonth,
      expirationYear: expirationYear,
    );
  }
}
