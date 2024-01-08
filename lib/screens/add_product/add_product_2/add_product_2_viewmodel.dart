import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/api_base_helper.dart';
import 'package:ismmart_vms/helper/constants.dart';
import 'package:ismmart_vms/helper/global_variables.dart';
import 'package:ismmart_vms/helper/urls.dart';
import 'package:ismmart_vms/screens/add_product/add_product_1/model/pictures_model.dart';
import 'package:ismmart_vms/screens/add_product/add_product_2/location_inventory_model.dart';
import 'package:ismmart_vms/screens/add_product/add_product_3/add_product_3_view.dart';
import '../../../models/variant_selection_model.dart';
import '../../../widgets/widget_models/variant_options_field_model.dart';

class AddProduct2ViewModel extends GetxController {

  List<String> combinations = [];
  List<String> combinations2 = [];
  ScrollController scrollController = ScrollController();
  RxList<VariantSelectionModel> finalCombinationsList = <VariantSelectionModel>[].obs;
  RxList<VariantsOptionsFieldModel> listOfOptionsAdded = <VariantsOptionsFieldModel>[].obs;
  RxList<LocationInventoryModel> locationInventoryList = <LocationInventoryModel>[].obs;
  RxBool showVariantsData = false.obs;
  RxBool trackQuantity = true.obs;
  final GlobalKey<FormState> variantsFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> variantsInventoryFormKey = GlobalKey<FormState>();
  TextEditingController weightController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  TextEditingController widthController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  Map<String, dynamic> previousDetails = {};
  List<PicturesModel> images = <PicturesModel>[];

  @override
  void onInit() {
    previousDetails = Get.arguments['productDetails'];
    images = Get.arguments['productImages'];
    print(images);
    super.onInit();
  }

  @override
  void onReady() {
    scrollController.addListener(() {
      if (scrollController.offset == scrollController.position.maxScrollExtent) {
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
      print(e);
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
        finalCombinationsList.clear();
        listOfOptionsAdded[0].optionValues?.forEach((element) {
          finalCombinationsList.add(VariantSelectionModel(
              variantName: element.text, variantSelected: false));
          finalCombinationsList.refresh();
          if(element == listOfOptionsAdded[0].optionValues?.last) {
            showVariantsData.value = true;
            assignInventoryToVariants();
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
            showVariantsData.value = true;
            assignInventoryToVariants();
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
              showVariantsData.value = true;
              assignInventoryToVariants();
            }
          }
        });
      }
    }
  }

  assignInventoryToVariants(){
    for(var i in finalCombinationsList){
      i.locationInventory = [];
      finalCombinationsList.refresh();
      for(var j in locationInventoryList) {
        i.locationInventory?.add(LocationInventory(
          id: j.sId,
          locationName: j.name,
          weight: double.tryParse(weightController.text),
          length: int.tryParse(lengthController.text),
          width: int.tryParse(widthController.text),
          height: int.tryParse(heightController.text)
        ));
        finalCombinationsList.refresh();
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

  createJson() {

    for(int i = 0; i<=listOfOptionsAdded.length-1 ; i++){
      previousDetails.addAll({
        "options[$i][name]": listOfOptionsAdded[i].optionName?.text,
      });
      for(int j = 0; j <= listOfOptionsAdded[i].optionValues!.length - 1; j++){
        previousDetails.addAll({
          "options[$i][values][$j]": listOfOptionsAdded[i].optionValues?[j].text
        });
      }
    }
    for(int i = 0; i <= finalCombinationsList.length-1 ; i++) {
      previousDetails.addAll({
        "variants[$i][variantId]": i,
        // "variants[$i][weight]": weightController.text,
        // "variants[$i][dimensions][length]": lengthController.text,
        // "variants[$i][dimensions][width]": widthController.text,
        // "variants[$i][dimensions][height]": heightController.text,
      });
      final splitted = finalCombinationsList[i].variantName?.split(' - ');
      if(splitted!.length > 1) {
        for (int j = 0; j <= splitted.length - 1; j++) {
          previousDetails.addAll({
            "variants[$i][options][$j]": splitted[j],
          });
        }
      } else {
        previousDetails.addAll({
          'variants[$i][options][0]': splitted[0]
        });
      }
      for(int k = 0; k <= finalCombinationsList[i].locationInventory!.length - 1 ; k++) {
        previousDetails.addAll({
          "inventory[$k][location]": finalCombinationsList[i].locationInventory?[k].id,
          "inventory[$k][variant]": i,
          "inventory[$k][quantity]": finalCombinationsList[i].locationInventory?[k].quantity,
          "inventory[$k][price]": finalCombinationsList[i].locationInventory?[k].price,
          "inventory[$k][sku]": finalCombinationsList[i].locationInventory?[k].sku,
          "inventory[$k][barcode]": finalCombinationsList[i].locationInventory?[k].barcode,
        });
      }
      if(i == finalCombinationsList.length - 1){
        Get.to(() => AddProduct3View(), arguments: {
          'productDetails': previousDetails,
          'productImages' : images
        });
      }
    }
  }
}