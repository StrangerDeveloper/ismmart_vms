import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/screens/Order/order_tabContainer/orders_tab_model.dart';
import 'package:ismmart_vms/screens/Order/order_tabContainer/selection_popup_model.dart';

/// A controller class for the OrdersTabContainerPage.
///
/// This class manages the state of the OrdersTabContainerPage, including the
/// current ordersTabContainerModelObj
class OrdersTabContainerController extends GetxController
    with GetSingleTickerProviderStateMixin {
  OrdersTabContainerController(this.ordersTabContainerModelObj);

  Rx<OrdersTabContainerModel> ordersTabContainerModelObj;

  late TabController tabviewController =
      Get.put(TabController(vsync: this, length: 3));

  SelectionPopupModel? selectedDropDownValue;

  onSelected(dynamic value) {
    for (var element
        in ordersTabContainerModelObj.value.dropdownItemList.value) {
      element.isSelected = false;
      if (element.id == value.id) {
        element.isSelected = true;
      }
    }
    ordersTabContainerModelObj.value.dropdownItemList.refresh();
  }
}
