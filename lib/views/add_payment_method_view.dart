import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/config/route.dart';
import 'package:giys_frontend/controllers/payment_method.dart';
import 'package:giys_frontend/controllers/add_payment_method.dart';
import 'package:giys_frontend/utilitties/payment_method_input_formatter.dart';

import '../widget/scaffold.dart';

class AddPaymentMethodView extends StatelessWidget {
  final paymentMethodController = Get.put(PaymentMethodController());
  final addPaymentMethodController = Get.put(AddPaymentMethodController());

  AddPaymentMethodView({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Obx(
                () => Form(
                  child: Column(
                    children: [
                      TextFormField(
                        onChanged:
                            addPaymentMethodController.onCardNumberChange,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(16),
                          CardNumberInputFormatter(),
                        ],
                        decoration: InputDecoration(
                          hintText: 'Card number',
                          errorText: addPaymentMethodController
                              .cardNumberErrorText.value,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: TextFormField(
                          onChanged: addPaymentMethodController.onNameChange,
                          decoration: InputDecoration(
                            hintText: "Full name",
                            errorText:
                                addPaymentMethodController.nameErrorText.value,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              onChanged: addPaymentMethodController.onCVVChange,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(3),
                              ],
                              decoration: InputDecoration(
                                hintText: "CVV",
                                errorText: addPaymentMethodController
                                    .cvvErrorText.value,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              onChanged: addPaymentMethodController
                                  .onExpirationDateChange,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(4),
                                CardMonthInputFormatter(),
                              ],
                              decoration: InputDecoration(
                                  hintText: "MM/YY",
                                  errorText: addPaymentMethodController
                                      .expirationDateErrorText.value),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                Get.toNamed(RoutePath.paymentMethodPath);
                                Get.delete<AddPaymentMethodController>();
                              },
                              child: const Text("Cancel"),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                if (addPaymentMethodController.validate()) {
                                  final req = addPaymentMethodController
                                      .createAddPaymentMethodRequest();
                                  paymentMethodController
                                      .addPaymentMethods(req);
                                  Get.toNamed(RoutePath.paymentMethodPath);
                                  Get.delete<AddPaymentMethodController>();
                                }
                              },
                              child: const Text("Confirm"),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
