import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/api_base_helper.dart';
import 'package:ismmart_vms/helper/global_variables.dart';
import 'package:ismmart_vms/screens/order_listing/model/orderModel.dart';

import '../../helper/urls.dart';

class OrderListingViewModel extends GetxController {
  Rx<Data> orderItemModel = Data().obs;
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
    scrollController.addListener(() {
      getOrderListing();
    });
    getOrderListing();
    super.onInit();
  }

  Future<void> getOrderListing() async {
    await ApiBaseHelper()
        .getMethod(url: '${Urls.getOrders}$searchUrlValue')
        .then((response) {
      final data = response['data'];
      if (data != null) {
        orderItemList.clear();
        Data orderModel = Data.fromJson(data);
        orderItemModel.value = orderModel;
        orderItemList.addAll(orderModel.items!);
        print("Order item List ${orderItemList.length}");
      } else {
        scrollController.dispose();
        GlobalVariable.showLoader.value = false;
      }
    }).catchError((error) {
      scrollController.dispose();
      GlobalVariable.showLoader.value = false;
    });
  }

  fieldSelection(value) {
    print("Value $value");
    if (value == 'All') {
      searchUrlValue = '';
    } else {
      searchUrlValue = '?fulfilmentStatus=$value';
    }
    print("Search Url Value $searchUrlValue");
    getOrderListing(); // Refresh the listing after applying the filter
  }
}
