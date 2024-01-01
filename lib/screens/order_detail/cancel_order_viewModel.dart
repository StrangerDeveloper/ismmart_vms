import 'package:get/get.dart';

import '../order_listing/model/orderModel.dart';

class CancelORderViewMOdel extends GetxController {
  RxBool selectAllValue = false.obs;
  Rx<OrderItem> orderItemModel = OrderItem().obs;
  RxList<Lineitem> lineItemList = <Lineitem>[].obs;
  RxList<Lineitem> selectedItems = <Lineitem>[].obs;


  @override
  void onInit() {
    orderItemModel.value = Get.arguments['model'];
    lineItemList.addAll(orderItemModel.value.lineitems ?? []);
    super.onInit();
  }

  selectAllItems() {
    selectAllValue.value = !selectAllValue.value;
    if (selectAllValue.value) {
      if (selectedItems.isEmpty) {
        for (int i = 0; i < (lineItemList.length); i++) {
          Lineitem model = lineItemList[i];
          model.isSelected = true;

          lineItemList[i] = model;
          selectedItems.add(model);
        }
      } else {
        for (int i = 0; i < (lineItemList.length); i++) {
          Lineitem model = lineItemList[i];
          model.isSelected = true;
          lineItemList[i] = model;
        }
        selectedItems.clear();
        selectedItems.addAll(lineItemList);
      }
    } else {
      for (int i = 0; i < (lineItemList.length); i++) {
        Lineitem model = lineItemList[i];
        model.isSelected = false;
        lineItemList[i] = model;
      }
      selectedItems.clear();
    }
  }

  selectSingleItem(bool value, int index) {
    Lineitem model = lineItemList[index];
    model.isSelected = value;
    lineItemList[index] = model;
  }
}
