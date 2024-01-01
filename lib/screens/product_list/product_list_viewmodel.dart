import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/api_base_helper.dart';
import 'package:ismmart_vms/screens/product_list/product_model.dart';

class ProductListViewModel extends GetxController {
  RxString searchBy = 'All'.obs;
  List<String> searchFilters = <String>['All', 'Status', 'Location', 'Variant'];
  RxDouble dropdownSelectionContainerWidth = 0.0.obs;
  RxDouble searchAndFilterContainerWidth = 0.0.obs;
  double higherContainerWidth = 0.65;
  double lowerContainerWidth = 0.2;
  RxBool searchByDropdownVisibility = false.obs;
  RxBool filterDropdownVisibility = false.obs;
  RxBool searchAndFilterIconVisibility = false.obs;
  RxBool searchByContainerIconVisibility = true.obs;

  RxList<ProductsItem> productItemsList = <ProductsItem>[].obs;

  RxInt page = 1.obs;
  int limit = 10;
  Rx<ProductModel> productModel = ProductModel().obs;

  @override
  void onReady() {
    dropdownSelectionContainerWidth.value = Get.width * higherContainerWidth;
    searchAndFilterContainerWidth.value = Get.width * lowerContainerWidth;
    Future.delayed(const Duration(milliseconds: 900), () {
      searchAndFilterIconVisibility.value = true;
    });

    getProductItems();
    super.onReady();
  }

  void changePage() {
    page.value++;
  }

  Future<void> getProductItems() async {
    await ApiBaseHelper()
        .getMethod(url: "/vendor/product?page=${page.value}&limit=$limit")
        .then((parsedJson) {
      final data = parsedJson['data'];
      if (data != null) {
        print("GetProductList: $data");
        productModel.value = ProductModel.fromJson(data);
        productItemsList.addAll(productModel.value.items!);
      }
    }).catchError((e) {
      debugPrint("GetProductList: $e");
    });
  }
}
