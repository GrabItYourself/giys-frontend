import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/controllers/payment_method.dart';
import 'package:giys_frontend/controllers/add_payment_method.dart';
import 'package:giys_frontend/utilitties/payment_method_input_formatter.dart';

import '../widget/scaffold.dart';

class AddPaymentMethodView extends StatelessWidget {
  final paymentMethodController = Get.find<PaymentMethodController>();
  final addPaymentMethodController = Get.put(AddPaymentMethodController());

  AddPaymentMethodView({super.key});

  //TODO: error message
  Future<void> onConfirm() async {
    if (addPaymentMethodController.validate()) {
      final req = addPaymentMethodController.createAddPaymentMethodRequest();
      paymentMethodController.addPaymentMethods(req);
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: "Add New Card",
      back: true,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Obx(
              () => Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller:
                          addPaymentMethodController.cardNumberController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
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
                        controller: addPaymentMethodController.nameController,
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
                            controller:
                                addPaymentMethodController.cvvController,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                              LengthLimitingTextInputFormatter(3),
                            ],
                            decoration: InputDecoration(
                              hintText: "CVV",
                              errorText:
                                  addPaymentMethodController.cvvErrorText.value,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: addPaymentMethodController
                                .expirationDateController,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
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
                            onPressed: (() => Get.back()),
                            child: const Text("Cancel"),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: onConfirm,
                            child: const Text("Confirm"),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
