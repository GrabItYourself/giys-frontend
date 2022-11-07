import 'package:get/get.dart';
import 'package:giys_frontend/models/payment_method.dart';

class PaymentMethodController extends GetxController {
  final paymentMethods = <PaymentMethod>[].obs;

  @override
  void onInit() async {
    super.onInit();
    try {
      paymentMethods.value = await getMyPaymentMethods();
    } catch (err) {
      return Future.error(err);
    }
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
    // TODO: Call api
    for (var paymentMethod in paymentMethods) {
      paymentMethod.isDefault = false;
    }
    paymentMethods[index].isDefault = true;
    paymentMethods.refresh();
  }

  Future<void> addPaymentMethods(AddPaymentMethodRequest req) async {
    // TODO: Call api
    paymentMethods.add(PaymentMethod(
      id: 123,
      lastFourDigits: req.cardNumber.substring(0, 4),
      isDefault: false,
    ));
    paymentMethods.refresh();
  }
}
