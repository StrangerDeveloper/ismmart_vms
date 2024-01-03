import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/api_base_helper.dart';
import 'package:ismmart_vms/helper/constants.dart';
import 'package:ismmart_vms/helper/global_variables.dart';
import 'package:ismmart_vms/helper/urls.dart';
import 'package:ismmart_vms/screens/add_product/add_product_2/location_inventory_model.dart';
import '../../../models/variant_selection_model.dart';
import '../../../widgets/widget_models/dropdown_model.dart';
import '../../../widgets/widget_models/variant_options_field_model.dart';

class AddProduct2ViewModel extends GetxController {

  List<String> combinations = [];
  ScrollController scrollController = ScrollController();
  RxList<VariantSelectionModel> finalCombinationsList =
      <VariantSelectionModel>[].obs;
  List<String> combinations2 = [];
  RxList<VariantsOptionsFieldModel> listOfOptionsAdded =
      <VariantsOptionsFieldModel>[].obs;
  RxString locationSelected = ''.obs;
  RxBool showVariantsField = false.obs;
  RxBool showVariantsTable = false.obs;
  RxBool trackQuantity = true.obs;
  RxList<LocationInventoryModel> locationInventoryList = <LocationInventoryModel>[].obs;
  // RxList<DropDownModel> locationsList = <DropDownModel>[
  //   DropDownModel(id: '1', name: 'All Locations'),
  //   DropDownModel(id: '2', name: 'Safa Gold Mall'),
  //   DropDownModel(id: '3', name: 'Giga Mall'),
  //   DropDownModel(id: '4', name: 'Amanah Mall')
  // ].obs;

  final GlobalKey<FormState> variantsFormKey = GlobalKey<FormState>();

  @override
  void onReady() {
    scrollController.addListener(() {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        listOfOptionsAdded.refresh();
      }
    });
    getInventoryLocations();
    super.onReady();
  }

  getInventoryLocations() {

    GlobalVariable.showLoader.value = true;

    ApiBaseHelper().getMethod(url: Urls.getInventoryLocation).then((parsedJson) {
      if(parsedJson['success'] == true) {
        GlobalVariable.showLoader.value = false;
        final data = parsedJson['data']['items'] as List;
        if(data.isNotEmpty) {
          locationInventoryList.addAll(data.map((e) => LocationInventoryModel.fromJson(e)));
        }
      }
    }).catchError((e) {
      GlobalVariable.showLoader.value = false;
      AppConstant.displaySnackBar('Error', e);
    });
  }
  
  creatingVariants() {
    combinations.clear();
    if (listOfOptionsAdded.isNotEmpty) {
      if (listOfOptionsAdded.length > 1) {
        variantsFunction(0, 1);
      } else {
        combinations.clear();
        listOfOptionsAdded[0].optionValues?.forEach((element) {
          finalCombinationsList.add(VariantSelectionModel(
              variantName: element.text, variantSelected: false));
          finalCombinationsList.refresh();
          if(element == listOfOptionsAdded[0].optionValues?.last) {
            showVariantsTable.value = true;
          }
        });
      }
    }
  }

  variantsFunction(int initialIndex, int nextIndex) {
    List<String> tempCombinations = <String>[];
    combinations.clear();
    combinations.addAll(combinations2.map((e) => e));
    combinations2.clear();
    if (initialIndex == 0) {
      listOfOptionsAdded[0].optionValues?.forEach((element) {
        String name = element.text;
        listOfOptionsAdded[1].optionValues?.forEach((element2) {
          name = "${element.text} - ${element2.text}";
          combinations2.add(name);
          if (element == listOfOptionsAdded[0].optionValues?.last &&
              element2 == listOfOptionsAdded[1].optionValues?.last &&
              nextIndex != listOfOptionsAdded.length - 1) {
            variantsFunction(initialIndex + 1, nextIndex + 1);
          } else {
            finalCombinationsList.clear();
            finalCombinationsList.addAll(combinations2.map((e) =>
                VariantSelectionModel(variantSelected: false, variantName: e)));
            finalCombinationsList.refresh();
            showVariantsTable.value = true;
            showVariantsField.value = true;
          }
        });
      });
    } else {
      for (var element in combinations) {
        String name = element;
        listOfOptionsAdded[nextIndex].optionValues?.forEach((listElement) {
          name = '$element - ${listElement.text}';
          tempCombinations.add(name);
          if (element == combinations.last &&
              listElement == listOfOptionsAdded[nextIndex].optionValues?.last) {
            combinations2.addAll(tempCombinations.map((e) => e));
            if (nextIndex != listOfOptionsAdded.length - 1) {
              variantsFunction(initialIndex + 1, nextIndex + 1);
            } else {
              finalCombinationsList.clear();
              finalCombinationsList.addAll(tempCombinations.map((e) =>
                  VariantSelectionModel(
                      variantName: e, variantSelected: false)));
              finalCombinationsList.refresh();
              showVariantsTable.value = true;
              showVariantsField.value = true;
            }
          }
        });
      }
    }
  }

  checkAndClearVariantBottomSheet(List<int> indexes) {
    if(indexes.isEmpty){
      Get.back();
    } else {
      for(int i in indexes) {
        listOfOptionsAdded.removeAt(i);
        listOfOptionsAdded.refresh();
        if(i == indexes.last) {
          Get.back();
        }
      }
    }
  }
}
