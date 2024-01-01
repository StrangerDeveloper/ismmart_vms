import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/api_base_helper.dart';
import 'package:ismmart_vms/helper/global_variables.dart';
import 'package:ismmart_vms/screens/order_listing/model/orderModel.dart';

import '../../helper/urls.dart';

class OrderListingViewModel extends GetxController {
  RxList<OrderItem> orderItemList = <OrderItem>[].obs;
  RxBool showSearchTxtField = false.obs;

  TextEditingController searchController = TextEditingController();

  ScrollController scrollController = ScrollController();

  @override
  void onReady() {
    scrollController.addListener(() {
      getOrderListing();
    });

    getOrderListing();
    super.onReady();
  }

  Future<void> getOrderListing() async {
    await ApiBaseHelper().getMethod(url: Urls.getOrders).then((response) {
      final data = response['data'];
      if (data != null) {
        Data orderModel = Data.fromJson(data);

        orderItemList.addAll(orderModel.items!);
        orderItemList.refresh();
      } else {
        scrollController.dispose();
        GlobalVariable.showLoader.value = false;
      }
    }).catchError((error) {
      scrollController.dispose();
      GlobalVariable.showLoader.value = false;
    });
  }
}
