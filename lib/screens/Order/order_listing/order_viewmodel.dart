import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/api_base_helper.dart';
import 'package:ismmart_vms/helper/global_variables.dart';
import 'package:ismmart_vms/screens/Order/order_listing/model/orderModel.dart';

import '../../../helper/constants.dart';
import '../../../helper/urls.dart';

class OrderListingViewModel extends GetxController {
  RxList<OrderItem> orderItemList = <OrderItem>[].obs;
  RxBool showSearchTxtField = false.obs;
  String searchUrlValue = '';
  RxString filterRadioBtn = 'all'.obs;
  String radioBtnUrlValue = '';

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
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();

    GlobalVariable.showLoader.value = true;
    getOrderListing();
  }

  @override
  void onClose() {
    GlobalVariable.showLoader.value = false;
    super.onClose();
  }

  Future<void> getOrderListing() async {
    GlobalVariable.showLoader.value = true;

    await ApiBaseHelper()
        .getMethod(url: '${Urls.getOrders}$searchUrlValue')
        .then((response) {
      var data = response['data']['items'] as List;
      if (response['success'] == true) {
        GlobalVariable.showLoader.value = false;
        orderItemList.clear();
        orderItemList.addAll(data.map((e) => OrderItem.fromJson(e)));
      } else {
        AppConstant.displaySnackBar(
          "Error",
          response['message'],
        );
        GlobalVariable.showLoader.value = false;
      }
    }).catchError((error) {
      AppConstant.displaySnackBar(
        "Error",
        error.toString(),
      );
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

  radioBtnSelection(String value) {
    filterRadioBtn.value = value;
    if (value == 'all') {
      radioBtnUrlValue = '';
    } else {
      radioBtnUrlValue = '&status=$value';
    }
  }
}
