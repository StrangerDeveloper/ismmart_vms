import 'package:get/get.dart';

import '../model/order_model.dart';

/// A controller class for the OrdersPage.
///
/// This class manages the state of the OrdersPage, including the
/// current ordersModelObj
class OrdersController extends GetxController {
  OrdersController(this.ordersModelObj);

  Rx<OrdersModel> ordersModelObj;
}
