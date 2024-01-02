import 'package:get/get.dart';

import '../order_listing/model/orderModel.dart';

class OrderDetailViewModel extends GetxController {
  Rx<OrderItem> orderItemModel = OrderItem().obs;
  RxList<Lineitem> lineItemList = <Lineitem>[].obs;
  RxList<Lineitem> selectedItems = <Lineitem>[].obs;

  @override
  void onInit() {
    orderItemModel.value = Get.arguments['model'];
    lineItemList.addAll(orderItemModel.value.lineitems ?? []);
    super.onInit();
  }

  // Future<void> updateORderDetail() async {
  //   try {}
  // }
}
