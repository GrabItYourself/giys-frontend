// import 'dart:developer';

// import 'package:get/get.dart';
// import 'package:giys_frontend/config/config.dart';
// import 'package:requests/requests.dart';

// class OrderSendController extends GetxController {
//   //TODO complete this
//   sendOrder(int shopId, Order order) async {
//     final response = await Requests.get(
//       '${Config.getServerUrl()}/api/v1/shops/$shopId/orders',
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       json: {"items": order.items},
//     );
//     log(response.toString());
//     response.raiseForStatus();
//   }
// }
