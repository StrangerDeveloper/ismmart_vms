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
  double lowerContainerWidth = 0.19;
  RxBool searchByDropdownVisibility = false.obs;
  RxBool filterDropdownVisibility = false.obs;
  RxBool searchAndFilterIconVisibility = false.obs;
  RxBool searchByContainerIconVisibility = true.obs;

  RxList<ProductsItem> productItemsList = <ProductsItem>[].obs;

  @override
  void onReady() {
    dropdownSelectionContainerWidth.value = Get.width * higherContainerWidth;
    searchAndFilterContainerWidth.value = Get.width * lowerContainerWidth;
    Future.delayed(const Duration(milliseconds: 800), () {
      searchAndFilterIconVisibility.value = true;
    });

    getProductItems();
    super.onReady();
  }

  Future<void> getProductItems() async{
    await ApiBaseHelper()
        .getMethod(url: "vendor/product?page=1&limit=10")
        .then((parsedJson) {
      final data = parsedJson['data'];
      if (data != null) {
        ProductModel model = ProductModel.fromJson(data);
        productItemsList.addAll(model.items!);
      }
    }).catchError((e) {
      debugPrint("GetProductItem: $e");
    });
  }
}
