import 'package:get/get.dart';
import 'package:ismmart_vms/helper/languages/translations_key.dart';

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

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    dropdownSelectionContainerWidth.value = Get.width * higherContainerWidth;
    searchAndFilterContainerWidth.value = Get.width * lowerContainerWidth;
    Future.delayed(Duration(milliseconds: 800), () {
      searchAndFilterIconVisibility.value = true;
    });
    super.onReady();
  }
}
