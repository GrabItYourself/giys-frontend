import 'dart:developer';

import 'package:get/get.dart';
import 'package:giys_frontend/config/config.dart';
import 'package:giys_frontend/models/order.dart';
import 'package:requests/requests.dart';

class OrderSendController extends GetxController {
  sendOrder(int shopId, List<OrderItem> items) async {
    try {
      final response = await Requests.post(
        '${Config.getServerUrl()}/api/v1/shops/$shopId/orders',
        headers: {
          'Content-Type': 'application/json',
        },
        json: {"items": items},
      );
      response.raiseForStatus();
    } catch (e) {
      print("ERROR in order send $e");
    }
  }
}
