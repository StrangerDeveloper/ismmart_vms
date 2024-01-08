import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/api_base_helper.dart';
import 'package:ismmart_vms/helper/global_variables.dart';
import 'package:ismmart_vms/screens/order_listing/model/orderModel.dart';

import '../../helper/urls.dart';

class OrderListingViewModel extends GetxController {
  //Rx<OrderItem> orderItemModel = OrderItem().obs;
  RxList<OrderItem> orderItemList = <OrderItem>[].obs;
  RxBool showSearchTxtField = false.obs;
  String searchUrlValue = '';

  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();

  //status
  RxInt statusSelectedIndex = 0.obs;
  List<String> statusList = const <String>[
    'All',
    "Unfulfilled",
    "Fulfilled",
    "Partially fulfilled",
    "Scheduled",
    "Returned",
    "Cancelled",
    "On hold",
  ];

  @override
  void onInit() {
    GlobalVariable.showLoader.value = false;
    // scrollController.addListener(() {
    //   getOrderListing();
    // });
    getOrderListing();
    super.onInit();
  }

  @override
  void onClose() {
    GlobalVariable.showLoader.value = false;
    super.onClose();
  }

  Future<void> getOrderListing() async {
    await ApiBaseHelper()
        .getMethod(url: '${Urls.getOrders}$searchUrlValue')
        .then((response) {
      var data = response['data']['items'] as List;
      if (response['success'] == true) {
        orderItemList.clear();
        orderItemList.addAll(data.map((e) => OrderItem.fromJson(e)));
      } else {
        //scrollController.dispose();
        GlobalVariable.showLoader.value = false;
      }
    }).catchError((error) {
      //scrollController.dispose();
      GlobalVariable.showLoader.value = false;
    });
  }

  fieldSelection(value) {
    if (value == 'All') {
      searchUrlValue = '';
    } else {
      searchUrlValue = '?fulfilmentStatus=$value';
    }
    getOrderListing(); // Refresh the listing after applying the filter
  }
}
