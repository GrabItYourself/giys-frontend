import 'package:get/get.dart';
import 'package:giys_frontend/models/payment_method.dart';

class AddPaymentMethodController extends GetxController {
  final cardNumber = ''.obs;
  final cardNumberStr = ''.obs;
  final cardNumberErrorText = Rx<String?>(null);

  final name = ''.obs;
  final nameStr = ''.obs;
  final nameErrorText = Rx<String?>(null);

  final cvv = ''.obs;
  final cvvStr = ''.obs;
  final cvvErrorText = Rx<String?>(null);

  final expirationMonth = RxInt(0);
  final expirationYear = RxInt(0);
  final expirationDateStr = ''.obs;
  final expirationDateErrorText = Rx<String?>(null);

  void onCardNumberChange(String val) {
    cardNumberStr.value = val;
  }

  void onNameChange(String val) {
    nameStr.value = val;
  }

  void onCVVChange(String val) {
    cvvStr.value = val;
  }

  void onExpirationDateChange(String val) {
    expirationDateStr.value = val;
  }

  bool validate() {
    var valid = true;

    cardNumber.value = cardNumberStr.value.replaceAll(" ", "");
    if (cardNumber.value.isEmpty || cardNumber.value.length != 16) {
      cardNumberErrorText.value = 'Please enter valid card number';
      valid = false;
    } else {
      cardNumberErrorText.value = null;
    }

    name.value = nameStr.value;
    if (name.value.isEmpty) {
      nameErrorText.value = 'Please enter valid name';
      valid = false;
    } else {
      nameErrorText.value = null;
    }

    cvv.value = cvvStr.value;
    if (cvv.value.isEmpty || cvv.value.length < 3) {
      cvvErrorText.value = 'Please enter valid cvv';
      valid = false;
    } else {
      cvvErrorText.value = null;
    }

    if (expirationDateStr.value.length < 5) {
      expirationDateErrorText.value = 'Please enter valid date';
      valid = false;
    } else {
      expirationMonth.value =
          int.parse(expirationDateStr.value.substring(0, 2));
      expirationYear.value =
          int.parse(expirationDateStr.value.substring(3, 5)) + 2000;

      if (expirationMonth.value <= 0 || expirationMonth.value > 12) {
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
      cardNumber: cardNumber.value,
      name: name.value,
      cvv: cvv.value,
      expirationMonth: expirationMonth.value,
      expirationYear: expirationYear.value,
    );
  }
}
