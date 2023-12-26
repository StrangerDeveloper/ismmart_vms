import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/screens/payout_list/payout_model.dart';

import '../../helper/api_base_helper.dart';
import '../../helper/constants.dart';
import '../../helper/global_variables.dart';
import '../../helper/urls.dart';

class PayoutListViewModel extends GetxController {
  RxString searchBy = 'name'.obs;
  List<String> dataList = <String>['asdsad', 'asdsad', 'asdsad'].obs;
  ////////////////
  List<PayoutModel> payoutList = <PayoutModel>[].obs;
  // RxInt totalLeaves = 0.obs;
  ScrollController scrollController = ScrollController();
  int pageNo = 0;
  RxBool paginationLoader = false.obs;

  @override
  Future<void> onReady() async {
    GlobalVariable.showLoader.value = true;
    scrollController.addListener(() {
      getData();
    });
    await getData();
    GlobalVariable.showLoader.value = false;
  }

  getData() async {
    if (pageNo == 0
        ? true
        : (scrollController.hasClients && scrollController.position.maxScrollExtent == scrollController.offset)) {
      pageNo++;
      paginationLoader.value = true;
      await ApiBaseHelper()
          .getMethod(
          url: '${Urls.getPayout}')
          .then((parsedJson) {
        if (parsedJson['success'] == true && parsedJson['data']['items'] != null) {
          var data = parsedJson['data']['items'] as List;
          // totalLeaves.value = parsedJson['data']['total'];
          if (data.isEmpty) {
            scrollController.dispose();
          }
          payoutList.addAll(data.map((e) => PayoutModel.fromJson(e)));
          // filterData();
          paginationLoader.value = false;
        } else {
          AppConstant.displaySnackBar('Errors', parsedJson['message']);
        }
      }).catchError((e) {
        print(e);
      });
    }
  }


}
