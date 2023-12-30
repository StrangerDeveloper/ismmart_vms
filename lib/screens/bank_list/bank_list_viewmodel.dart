import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/api_base_helper.dart';
import '../../helper/common_function.dart';
import '../../helper/constants.dart';
import '../../helper/global_variables.dart';
import '../../helper/urls.dart';
import '../location_list/location_model.dart';

class BankListViewModel extends GetxController {
  RxBool showSearchTxtField = false.obs;
  TextEditingController searchController = TextEditingController();
  String searchUrlValue = '';
  List<LocationModel> dataList = <LocationModel>[].obs;
  RxString filterRadioBtn = 'all'.obs;
  String radioBtnUrlValue = '';

  // @override
  // Future<void> onReady() async {
  //   getData();
  // }

  @override
  void onClose() {
    GlobalVariable.showLoader.value = false;
    super.onClose();
  }

  searchTxtFieldSubmitted(String value) async {
    if (value == '') {
      searchUrlValue = '';
    } else {
      searchUrlValue = '&text=$value';
    }
    await getData();
  }

  radioBtnSelection(String value) {
    filterRadioBtn.value = value;
    if (value == 'all') {
      radioBtnUrlValue = '';
    } else {
      radioBtnUrlValue = '&status=$value';
    }
  }

  getData() async {
    GlobalVariable.showLoader.value = true;
    await ApiBaseHelper().getMethod(url: Urls.getLocation).then((parsedJson) {
      GlobalVariable.showLoader.value = false;
      if (parsedJson['success'] == true &&
          parsedJson['data']['items'] != null) {
        dataList.clear();
        var data = parsedJson['data']['items'] as List;
        dataList.addAll(data.map((e) => LocationModel.fromJson(e)));
      } else {
        AppConstant.displaySnackBar('Errors', parsedJson['message']);
      }
    }).catchError((e) {
      CommonFunction.debugPrint(e);
    });
  }
}
