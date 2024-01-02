import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/screens/bank_list/bank_model.dart';

import '../../helper/api_base_helper.dart';
import '../../helper/common_function.dart';
import '../../helper/constants.dart';
import '../../helper/global_variables.dart';
import '../../helper/urls.dart';

class BankListViewModel extends GetxController {
  TextEditingController searchController = TextEditingController();
  String searchUrlValue = '';
  List<BankModel> dataList = <BankModel>[].obs;

  @override
  void onReady() {
    getData();
    super.onReady();
  }

  @override
  void onClose() {
    GlobalVariable.showLoader.value = false;
    super.onClose();
  }

  searchTxtFieldSubmitted(String value) {
    if (value == '') {
      searchUrlValue = '';
    } else {
      searchUrlValue = '?&text=$value';
    }
    getData();
  }

  getData() async {
    GlobalVariable.showLoader.value = true;
    await ApiBaseHelper()
        .getMethod(url: '${Urls.getBank}$searchUrlValue')
        .then((parsedJson) {
      GlobalVariable.showLoader.value = false;

      if (parsedJson['success'] == true && parsedJson['data']['items'] != null) {
        dataList.clear();
        var data = parsedJson['data']['items'] as List;
        dataList.addAll(data.map((e) => BankModel.fromJson(e)));
      } else {
        AppConstant.displaySnackBar('Errors', parsedJson['message']);
      }
    }).catchError((e) {
      CommonFunction.debugPrint(e);
    });
  }

  deleteRecord(int index) async {
    GlobalVariable.showLoader.value = true;
    await ApiBaseHelper()
        .deleteMethod(url: '${Urls.deleteBank}${dataList[index].sId}')
        .then((parsedJson) {
      GlobalVariable.showLoader.value = false;

      if (parsedJson['success'] == true && parsedJson['message'] == 'Bank deleted successfully') {
        dataList.removeAt(index);
        AppConstant.displaySnackBar('Success', parsedJson['message']);
      } else {
        AppConstant.displaySnackBar('Errors', parsedJson['message']);
      }
    }).catchError((e) {
      CommonFunction.debugPrint(e);
    });
  }

  String getFirstTwoChar(String value) {
    String finalName = '';
    try{
      value = value.trim();
      if (value.contains(' ')) {
        List<String> names = value.trim().split(" ");
        String firstName = names[0];
        String lastName = names[names.length - 1];

        finalName = firstName.substring(0, 1);
        finalName += lastName.substring(0, 1);
      } else {
        finalName = '${value.substring(0, 1)}B';
      }
    } catch(e){
      finalName = '';
    }
    return finalName;
  }
}
