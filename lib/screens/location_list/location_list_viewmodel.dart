import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/common_function.dart';
import 'package:ismmart_vms/screens/location_list/location_model.dart';

import '../../helper/api_base_helper.dart';
import '../../helper/constants.dart';
import '../../helper/global_variables.dart';
import '../../helper/urls.dart';

class LocationListViewModel extends GetxController {

  RxInt totalPages = 1.obs;
  TextEditingController searchController = TextEditingController();
  String radioBtnUrlValue = '';
  String searchUrlValue = '';
  RxString filterRadioBtn = 'all'.obs;
  RxBool showSearchTxtField = false.obs;
  List<LocationModel> dataList = <LocationModel>[].obs;
  ScrollController scrollController = ScrollController();
  RxInt currentPage = 0.obs;
  int pageNo = 0;
  RxBool paginationLoader = false.obs;
  dynamic arguments;
  bool cameFromAddProduct = false;
  RxBool showListLoader = false.obs;

  @override
  void onInit() {
    arguments = Get.arguments;
    if(arguments != null) {
      cameFromAddProduct = arguments['cameFromAddProduct'];
    }
    super.onInit();
  }

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

  onChangeSearching(String value) {
    if (value == '') {
      searchUrlValue = '';
    } else {
      searchUrlValue = '&text=$value';
    }
    getDataFunction();
  }

  getDataFunction() async {
    pageNo = 0;
    currentPage.value = 0;
    dataList.clear();
    scrollController.removeListener(getData);
    showListLoader.value = true;
    if (!scrollController.hasListeners) {
      scrollController = ScrollController();
      scrollController.addListener(getData);
    }
    await getData();
    showListLoader.value = false;
  }

  getData() async {
    if (pageNo == 0
        ? true
        : (scrollController.hasClients &&
            scrollController.position.maxScrollExtent ==
                scrollController.offset)) {
      pageNo++;
      currentPage.value++;
      paginationLoader.value = true;
      await ApiBaseHelper()
          .getMethod(
              url: '${Urls.getLocation}$pageNo$radioBtnUrlValue$searchUrlValue')
          .then((parsedJson) {
        if(pageNo == 1){
          dataList.clear();
        }
        if (parsedJson['success'] == true && parsedJson['data']['items'] != null) {
          var data = parsedJson['data']['items'] as List;
          totalPages.value = parsedJson['data']['pages'];
          if (data.isEmpty || data.length<10) {
            scrollController.removeListener(getData);
          }
          dataList.addAll(data.map((e) => LocationModel.fromJson(e)));
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
