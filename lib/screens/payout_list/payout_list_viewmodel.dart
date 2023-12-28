import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/screens/payout_list/payout_model.dart';

import '../../helper/api_base_helper.dart';
import '../../helper/common_function.dart';
import '../../helper/constants.dart';
import '../../helper/global_variables.dart';
import '../../helper/urls.dart';

class PayoutListViewModel extends GetxController {
  RxInt totalPages = 1.obs;
  TextEditingController searchController = TextEditingController();
  String radioBtnUrlValue = '';
  String searchUrlValue = '';
  RxString filterRadioBtn = 'all'.obs;
  RxBool showSearchTxtField = false.obs;
  List<PayoutModel> dataList = <PayoutModel>[].obs;
  ScrollController scrollController = ScrollController();
  int pageNo = 0;
  RxBool paginationLoader = false.obs;

  @override
  Future<void> onReady() async {
    getDataFunction();
  }

  @override
  void onClose() {
    GlobalVariable.showLoader.value = false;
    super.onClose();
  }

  radioBtnSelection(String value) {
    filterRadioBtn.value = value;
    if (value == 'all') {
      radioBtnUrlValue = '';
    } else {
      radioBtnUrlValue = '&status=$value';
    }
  }

  searchTxtFieldSubmitted(String value) {
    if (value == '') {
      searchUrlValue = '';
    } else {
      searchUrlValue = '&text=$value';
    }
    getDataFunction();
  }

  getDataFunction() async {
    pageNo = 0;
    dataList.clear();
    GlobalVariable.showLoader.value = true;
    if (!scrollController.hasListeners) {
      scrollController = ScrollController();
      scrollController.addListener(() {
        getData();
      });
    }
    await getData();
    GlobalVariable.showLoader.value = false;
  }

  getData() async {
    if (pageNo == 0
        ? true
        : (scrollController.hasClients &&
            scrollController.position.maxScrollExtent ==
                scrollController.offset)) {
      pageNo++;
      paginationLoader.value = true;
      await ApiBaseHelper()
          .getMethod(
              url: '${Urls.getPayout}$pageNo$radioBtnUrlValue$searchUrlValue')
          .then((parsedJson) {
        if (parsedJson['success'] == true &&
            parsedJson['data']['items'] != null) {
          var data = parsedJson['data']['items'] as List;
          totalPages.value = parsedJson['data']['pages'];
          if (data.isEmpty) {
            scrollController.dispose();
          }
          dataList.addAll(data.map((e) => PayoutModel.fromJson(e)));
          paginationLoader.value = false;
        } else {
          AppConstant.displaySnackBar('Errors', parsedJson['message']);
        }
      }).catchError((e) {
        CommonFunction.debugPrint(e);
      });
    }
  }
}
