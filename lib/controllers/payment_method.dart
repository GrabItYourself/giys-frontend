import 'package:get/get.dart';
import 'package:giys_frontend/models/payment_method.dart';
import 'package:requests/requests.dart';

import '../config/config.dart';
import '../config/route.dart';

class PaymentMethodController extends GetxController {
  final paymentMethods = <PaymentMethod>[].obs;

  @override
  void onInit() async {
    super.onInit();
    try {
      await updateMyPaymentMethods();
    } catch (err) {
      Get.toNamed(RoutePath.loginPath);
      return Future.error(err);
    }
  }

  Future<void> updateMyPaymentMethods() async {
    paymentMethods.value = await getMyPaymentMethods();
  }

  Future<List<PaymentMethod>> getMyPaymentMethods() async {
    final response = await Requests.get(
      '${Config.getServerUrl()}/api/v1/user/me/paymentMethods',
      headers: {
        'Content-Type': 'application/json',
      },
    );
    response.raiseForStatus();

    final paymentMethods = <PaymentMethod>[];
    for (var item in response.json()) {
      paymentMethods.add(PaymentMethod.fromJson(item));
    }
    return paymentMethods;
  }

  Future<void> setDefaultPaymentMethods(int index) async {
    final response = await Requests.patch(
      '${Config.getServerUrl()}/api/v1/user/me/paymentMethods/${paymentMethods[index].id}/setDefault',
      headers: {
        'Content-Type': 'application/json',
      },
    );
    response.raiseForStatus();

    for (var paymentMethod in paymentMethods) {
      paymentMethod.isDefault = false;
    }
    paymentMethods[index].isDefault = true;
    paymentMethods.refresh();
  }

  Future<void> addPaymentMethods(AddPaymentMethodRequest req) async {
    final response = await Requests.post(
      '${Config.getServerUrl()}/api/v1/user/me/paymentMethods',
      headers: {
        'Content-Type': 'application/json',
      },
      json: req.toJson(),
    );
    response.raiseForStatus();

    paymentMethods.add(PaymentMethod.fromJson(response.json()));
    paymentMethods.refresh();
  }
}
