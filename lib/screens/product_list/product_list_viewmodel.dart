import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/global_variables.dart';
import 'package:ismmart_vms/screens/product_list/multiple_products_model.dart';
import 'package:ismmart_vms/screens/product_list/single_product_model.dart';

import '../../helper/api_base_helper.dart';
import '../../helper/common_function.dart';
import '../../helper/constants.dart';
import '../../helper/urls.dart';
import '../add_product/add_product_1/add_product_1_view.dart';

class ProductListViewModel extends GetxController {
  RxString searchBy = 'All'.obs;
  List<String> searchFilters = <String>['All', 'Active', 'InActive'];

  RxInt totalPages = 1.obs;
  TextEditingController searchController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  String radioBtnUrlValue = '';
  String searchUrlValue = '';
  RxString filterRadioBtn = 'all'.obs;
  RxBool showSearchTxtField = false.obs;
  ScrollController scrollController = ScrollController();
  RxInt currentPage = 0.obs;
  int pageNo = 0;
  RxBool paginationLoader = false.obs;
  Map<String, dynamic> arguments = {};
  RxBool cameFromSideBar = false.obs;
  RxBool showListLoader = false.obs;
  RxList<MultipleProductModel> dataList = <MultipleProductModel>[].obs;

  @override
  void onInit() {
    print(Get.arguments);
    if(Get.arguments != null) {
      print('Side Bar');
      cameFromSideBar.value = Get.arguments['cameFromSideBar'];
    }
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    statusController.text = 'All';
    getDataFunction();
  }

  @override
  void onClose() {
    searchController.dispose();
    statusController.dispose();
    GlobalVariable.showLoader.value = false;
    super.onClose();
  }


  radioBtnSelection(String value) {
    statusController.text = value;
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
          url: '${Urls.getProducts}$pageNo$radioBtnUrlValue$searchUrlValue')
          .then((parsedJson) {
        if (pageNo == 1) {
          dataList.clear();
        }
        if (parsedJson['success'] == true &&
            parsedJson['data']['items'] != null) {
          var data = parsedJson['data']['items'] as List;
          totalPages.value = parsedJson['data']['pages'];
          if (data.isEmpty || data.length < 10) {
            scrollController.removeListener(getData);
          }
          dataList.addAll(data.map((e) => MultipleProductModel.fromJson(e)));
          paginationLoader.value = false;
        } else {
          AppConstant.displaySnackBar('Errors', parsedJson['message']);
        }
      }).catchError((e) {
        CommonFunction.debugPrint(e);
      });
    }
  }

  getSingleProductDetails(String id) async {

    GlobalVariable.showLoader.value = true;

    ApiBaseHelper().getMethod(url: Urls.getSingleProduct + id).then((parsedJson) {
      GlobalVariable.showLoader.value = false;
      if(parsedJson['success'] == true) {
        Get.to(() => AddProduct1View(), arguments: {
          'productDetails': SingleProductModel.fromJson(parsedJson['data']['items'][0]),
          'cameFromProductList': true,
          'editProduct': true,
        });
      } else {
        AppConstant.displaySnackBar('Error', 'Product details couldn\'t be fetched');
      }
    }).catchError((e) {
      GlobalVariable.showLoader.value = false;
      AppConstant.displaySnackBar('Error', 'Error fetching product details');
    });
  }

}