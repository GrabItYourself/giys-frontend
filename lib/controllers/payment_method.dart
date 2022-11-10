import 'package:get/get.dart';
import 'package:giys_frontend/models/payment_method.dart';
import 'package:requests/requests.dart';
import 'dart:convert';

import '../config/config.dart';

class PaymentMethodController extends GetxController {
  final paymentMethods = <PaymentMethod>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await updateMyPaymentMethods();
  }

  Future<void> updateMyPaymentMethods() async {
    paymentMethods.value = await getMyPaymentMethods();
  }

  Future<List<PaymentMethod>> getMyPaymentMethods() async {
    // final response = await Requests.get(
    //   '${Config.serverUrl}/api/v1/user/me/paymentMethods',
    //   headers: {
    //     'Content-Type': 'application/json',
    //   },
    // );
    // response.raiseForStatus();

    // final paymentMethods = <PaymentMethod>[];
    // for (var item in jsonDecode(response.body)) {
    //   paymentMethods.add(PaymentMethod.fromJson(item));
    // }
    // return paymentMethods;

    await Future.delayed(const Duration(seconds: 1));
    final paymentMethods = <PaymentMethod>[];
    paymentMethods
        .add(PaymentMethod(id: 1, lastFourDigits: "1234", isDefault: false));
    paymentMethods
        .add(PaymentMethod(id: 2, lastFourDigits: "1234", isDefault: true));
    paymentMethods
        .add(PaymentMethod(id: 3, lastFourDigits: "1234", isDefault: false));
    paymentMethods
        .add(PaymentMethod(id: 4, lastFourDigits: "1234", isDefault: false));

    return paymentMethods;
  }

  Future<void> setDefaultPaymentMethods(int index) async {
    // final response = await Requests.patch(
    //   '${Config.serverUrl}/api/v1/user/me/paymentMethods/${paymentMethods[index].id}/setDefault',
    //   headers: {
    //     'Content-Type': 'application/json',
    //   },
    // );
    // response.raiseForStatus();

    await Future.delayed(const Duration(seconds: 1));
    for (var paymentMethod in paymentMethods) {
      paymentMethod.isDefault = false;
    }
    paymentMethods[index].isDefault = true;
    paymentMethods.refresh();
  }

  Future<void> addPaymentMethods(AddPaymentMethodRequest req) async {
    // final response = await Requests.post(
    //   '${Config.serverUrl}/api/v1/user/me/paymentMethods',
    //   headers: {
    //     'Content-Type': 'application/json',
    //   },
    //   json: req.toJson(),
    // );
    // response.raiseForStatus();

    // paymentMethods.add(PaymentMethod.fromJson(jsonDecode(response.body)));
    // paymentMethods.refresh();

    await Future.delayed(const Duration(seconds: 1));
    paymentMethods
        .add(PaymentMethod(id: 1, lastFourDigits: "1234", isDefault: false));
    paymentMethods.refresh();
  }
}
