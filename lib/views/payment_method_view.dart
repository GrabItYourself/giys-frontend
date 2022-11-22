import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/config/route.dart';
import 'package:giys_frontend/controllers/payment_method.dart';
import 'package:giys_frontend/widget/payment_method_list_tile.dart';

import '../widget/scaffold.dart';

class PaymentMethodView extends StatelessWidget {
  final paymentMethodController = Get.put(PaymentMethodController());

  PaymentMethodView({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: "Payment Methods",
      back: true,
      body: SafeArea(
        child: Center(
          child: GetX<PaymentMethodController>(
            builder: (controller) => RefreshIndicator(
              onRefresh: controller.updateMyPaymentMethods,
              child: ListView.separated(
                itemCount: controller.paymentMethods.length + 1,
                itemBuilder: (context, index) {
                  if (index == controller.paymentMethods.length) {
                    return ListTile(
                      title: Row(
                        children: const [
                          Icon(Icons.add),
                          SizedBox(width: 10),
                          Text("Add New Payment Method"),
                        ],
                      ),
                      onTap: () => Get.toNamed(RoutePath.addPaymentMethodPath),
                    );
                  }
                  return PaymentMethodListTile(
                    lastFourDigits:
                        controller.paymentMethods[index].lastFourDigits,
                    isDefault: controller.paymentMethods[index].isDefault,
                    onTap: () =>
                        paymentMethodController.setDefaultPaymentMethods(index),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
