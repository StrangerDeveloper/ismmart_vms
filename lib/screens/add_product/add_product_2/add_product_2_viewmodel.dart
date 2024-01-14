import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/api_base_helper.dart';
import 'package:ismmart_vms/helper/constants.dart';
import 'package:ismmart_vms/helper/global_variables.dart';
import 'package:ismmart_vms/helper/languages/translations_key.dart';
import 'package:ismmart_vms/helper/urls.dart';
import 'package:ismmart_vms/screens/add_product/add_product_2/location_inventory_model.dart';
import 'package:ismmart_vms/screens/add_product/add_product_3/add_product_3_view.dart';
import 'package:ismmart_vms/screens/location_list/location_model.dart';
import 'package:ismmart_vms/screens/product_list/single_product_model.dart';
import '../../../models/variant_selection_model.dart';
import '../../../widgets/widget_models/variant_options_field_model.dart';

class AddProduct2ViewModel extends GetxController {

  /// Variables for Variant Combinations and Displaying Variants Data
  List<String> combinations = [];
  List<String> combinations2 = [];
  RxBool showVariantsData = false.obs;
  RxList<VariantSelectionModel> finalCombinationsList = <VariantSelectionModel>[].obs;
  RxList<VariantSelectionModel> tempListForVariantCheck = <VariantSelectionModel>[].obs;
  RxList<VariantsOptionsFieldModel> listOfOptionsAdded = <VariantsOptionsFieldModel>[].obs;
  RxList<VariantsOptionsFieldModel> tempListOfOptionsAdded = <VariantsOptionsFieldModel>[].obs;
  RxList<LocationModel> locationsList = <LocationModel>[].obs;
  RxList<LocationInventoryModel> inventoryLocation = <LocationInventoryModel>[].obs;

  /// Controllers and Global Form Keys
  ScrollController scrollController = ScrollController();
  final GlobalKey<FormState> variantsFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> variantsInventoryFormKey = GlobalKey<FormState>();

  /// General Variables
  RxBool trackQuantity = true.obs;
  RxBool variantsChanged = false.obs;
  RxBool editProduct = false.obs;

  /// Variables for handling arguments
  Map<String, String> previousDetails = {};
  Map<String, dynamic> arguments = {};
  SingleProductModel oldDetails = SingleProductModel();
  bool cameFromProductList = false;

  ///Variables for Weight Field
  TextEditingController weightUnitController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  RxInt weightUnitSelectedIndex = 0.obs;
  List<String> weightUnitList = const <String>['kg', 'lbs', 'oz'];

  ///Variables for Length Field
  TextEditingController lengthUnitController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  RxInt lengthUnitSelectedIndex = 0.obs;
  List<String> lengthUnitList = const <String>['in', 'cm', 'meters'];

  ///Variables for Width Field
  TextEditingController widthUnitController = TextEditingController();
  TextEditingController widthController = TextEditingController();
  RxInt widthUnitSelectedIndex = 0.obs;
  List<String> widthUnitList = const <String>['in', 'cm', 'meters'];

  ///Variables for Height Field
  TextEditingController heightUnitController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  RxInt heightUnitSelectedIndex = 0.obs;
  List<String> heightUnitList = const <String>['in', 'cm', 'meters'];

  @override
  void onInit() {
    previousDetails = Get.arguments['productDetails'];
    cameFromProductList = Get.arguments['cameFromProductList'];
    editProduct.value = Get.arguments['editProduct'];
    if (editProduct.value) {
      oldDetails = Get.arguments['oldData'];
      fillData();
    }
    super.onInit();
  }

  @override
  void onReady() {
    weightUnitController.text = weightUnitList[weightUnitSelectedIndex.value];
    lengthUnitController.text = lengthUnitList[lengthUnitSelectedIndex.value];
    widthUnitController.text = widthUnitList[widthUnitSelectedIndex.value];
    heightUnitController.text = heightUnitList[heightUnitSelectedIndex.value];
    scrollController.addListener(() {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        listOfOptionsAdded.refresh();
      }
    });
    getInventoryLocations();
    super.onReady();
  }

  fillData() {
    for (var option in oldDetails.variants!) {
      finalCombinationsList.add(VariantSelectionModel(
          id: option.sId,
          totalInventoryQuantityValue: 0,
          variantName: option.name,
          locationInventory: <LocationInventory>[]
      ));
    }
    for(var option in oldDetails.options!) {
      TextEditingController optionName = TextEditingController();
      optionName.text = option.name!;
      listOfOptionsAdded.add(VariantsOptionsFieldModel(id: option.sId, optionName: optionName, optionValues: <TextEditingController>[]));
      tempListOfOptionsAdded.add(VariantsOptionsFieldModel(id: option.sId, optionName: optionName, optionValues: <TextEditingController>[]));
      for (var optionValue in option.values!) {
        TextEditingController value = TextEditingController();
        value.text = optionValue;
        listOfOptionsAdded.last.optionValues?.add(value);
        listOfOptionsAdded.refresh();
        tempListOfOptionsAdded.last.optionValues?.add(value);
        tempListOfOptionsAdded.refresh();
        }
      }
    }

  getVariantInventory() {

    GlobalVariable.showLoader.value = true;

    for (int i = 0 ; i <= finalCombinationsList.length - 1 ; i++) {

      ApiBaseHelper()
          .getMethod(url: Urls.getVariantInventory + finalCombinationsList[i].id!)
          .then((parsedJson) async {
        if (parsedJson['success'] == true) {
          inventoryLocation.clear();
          final data = parsedJson['data']['items'] as List;
          inventoryLocation.addAll(data.map((e) => LocationInventoryModel.fromJson(e)));
          await assignInventoryToVariant(i);
        }
      }).catchError((e) {
        GlobalVariable.showLoader.value = false;
      });
    }
  }

  getInventoryLocations() {
    GlobalVariable.showLoader.value = true;

    locationsList.clear();

    ApiBaseHelper().getMethod(url: Urls.getInventoryLocation).then((
        parsedJson) {
      if (parsedJson['success'] == true) {
        GlobalVariable.showLoader.value = false;
        final data = parsedJson['data']['items'] as List;
        if (data.isNotEmpty) {
          for (var element in data) {
            if (element['status'] == 'Active') {
              locationsList.add(LocationModel.fromJson(element));
              if(element == data.last && editProduct.value) {
                createVariantInventory();
              }
            }
          }
        }
      }
    }).catchError((e) {
      GlobalVariable.showLoader.value = false;
      AppConstant.displaySnackBar('Error', e);
    });
  }

  creatingVariantsForEdit() {
    combinations.clear();
    if (listOfOptionsAdded.isNotEmpty) {
      if (listOfOptionsAdded.length > 1) {
        variantsFunctionForEdit(0, 1);
      } else {
        combinations.clear();
        finalCombinationsList.clear();
        listOfOptionsAdded[0].optionValues?.forEach((element) {
          finalCombinationsList.add(VariantSelectionModel(
              variantName: element.text, variantSelected: false));
          finalCombinationsList.refresh();
          if (element == listOfOptionsAdded[0].optionValues?.last) {
            showVariantsData.value = true;
            createVariantInventoryWhenEdited();
          }
        });
      }
    }
  }

  variantsFunctionForEdit(int initialIndex, int nextIndex) {
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
            variantsFunctionForEdit(initialIndex + 1, nextIndex + 1);
          } else {
            finalCombinationsList.clear();
            finalCombinationsList.addAll(combinations2.map((e) =>
                VariantSelectionModel(variantSelected: false, variantName: e)));
            finalCombinationsList.refresh();
            showVariantsData.value = true;
            createVariantInventoryWhenEdited();
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
              variantsFunctionForEdit(initialIndex + 1, nextIndex + 1);
            } else {
              finalCombinationsList.clear();
              finalCombinationsList.addAll(tempCombinations.map((e) =>
                  VariantSelectionModel(
                      variantName: e, variantSelected: false)));
              finalCombinationsList.refresh();
              showVariantsData.value = true;
              createVariantInventoryWhenEdited();
            }
          }
        });
      }
    }
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
          if (element == listOfOptionsAdded[0].optionValues?.last) {
            showVariantsData.value = true;
            createVariantInventory();
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
            createVariantInventory();
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
              createVariantInventory();
            }
          }
        });
      }
    }
  }

  createVariantInventoryWhenEdited() {

    print('Creating Variants');

    for(int i = 0; i <= finalCombinationsList.length - 1; i++) {
      int index = tempListForVariantCheck.indexWhere((element) => element.variantName == finalCombinationsList[i].variantName);
      if(index == -1) {
        finalCombinationsList[i].locationInventory = [];
        finalCombinationsList.refresh();
        for (var j in locationsList) {
          finalCombinationsList[i].locationInventory?.add(LocationInventory(
            locationId: j.sId,
            locationName: j.name,
          ));
          finalCombinationsList.refresh();
        }
      } else {
        finalCombinationsList[i] = tempListForVariantCheck[index];
        print(finalCombinationsList[i].locationInventory?.length);
      }
    }
  }

  createVariantInventory() {
    for (var i in finalCombinationsList) {
      i.locationInventory = [];
      finalCombinationsList.refresh();
      for (var j in locationsList) {
        i.locationInventory?.add(LocationInventory(
          locationId: j.sId,
          locationName: j.name,
        ));
        finalCombinationsList.refresh();
      }
    }
    if(editProduct.value) {
      getVariantInventory();
    }
  }

  assignInventoryToVariant(int i) {
      for(var j in inventoryLocation) {
          for (var k in finalCombinationsList[i].locationInventory!) {
            if(j.location?.sId == k.locationId) {
              k.inventoryId = j.sId;
              k.price = j.price;
              k.barcode = j.barcode;
              k.sku = j.sku;
              k.quantity = j.quantity;
              finalCombinationsList[i].totalInventoryQuantityValue += k.quantity!;
              finalCombinationsList.refresh();
            }
          }
      }
      if(finalCombinationsList[i] == finalCombinationsList.last){
        GlobalVariable.showLoader.value = false;
        showVariantsData.value = true;
        for (var element in finalCombinationsList) {
          tempListForVariantCheck.add(element);
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
    if(editProduct.value){

      print(finalCombinationsList[0].locationInventory?[0].quantity);

        for (int i = 0; i <= listOfOptionsAdded.length - 1; i++) {
          previousDetails.addAll({"options[$i][name]": listOfOptionsAdded[i].optionName!.text,});
          if(listOfOptionsAdded[i].id != null) {
            previousDetails.addAll({"options[$i][_id]": listOfOptionsAdded[i].id!});
          }
          for (int j = 0; j <= listOfOptionsAdded[i].optionValues!.length - 1; j++) {
            previousDetails.addAll({"options[$i][values][$j]": listOfOptionsAdded[i].optionValues![j].text});
          }
        }
        for (int i = 0; i <= finalCombinationsList.length - 1; i++) {

          previousDetails.addAll({
            "variants[$i][weight]": finalCombinationsList[i].weight == null ? '0' : '${finalCombinationsList[i].weight}',
            "variants[$i][dimensions][length]": finalCombinationsList[i].dimensions?.length == null ? '0' : '${finalCombinationsList[i].dimensions?.length}',
            "variants[$i][dimensions][width]": finalCombinationsList[i].dimensions?.width == null ? '0' : '${finalCombinationsList[i].dimensions?.width}',
            "variants[$i][dimensions][height]": finalCombinationsList[i].dimensions?.height == null ? '0' : '${finalCombinationsList[i].dimensions?.height}'
          });

          if(finalCombinationsList[i].id != null) {
            previousDetails.addAll({
              "variants[$i][_id]": finalCombinationsList[i].id!
            });
          } else {
            previousDetails.addAll({
              "variants[$i][variantId]": "$i"
            });
          }

          final split = finalCombinationsList[i].variantName?.split(' - ');
          if (split!.length > 1) {
            for (int j = 0; j <= split.length - 1; j++) {
              previousDetails.addAll({
                "variants[$i][options][$j]": split[j],
              });
            }
          } else {
            previousDetails.addAll({'variants[$i][options][0]': split[0]});
          }

          for (int k = 0; k <= finalCombinationsList[i].locationInventory!.length - 1; k++) {
            previousDetails.addAll({
              "inventory[$k][location]": finalCombinationsList[i].locationInventory![k].locationId!,
              "inventory[$k][variant]": finalCombinationsList[i].id ?? "$i",
              "inventory[$k][quantity]": finalCombinationsList[i].locationInventory?[k].quantity == null ? '0' : "${finalCombinationsList[i].locationInventory![k].quantity!}",
              "inventory[$k][price]": finalCombinationsList[i].locationInventory?[k].price == null ? '0' : "${finalCombinationsList[i].locationInventory?[k].price}",
              "inventory[$k][sku]": finalCombinationsList[i].locationInventory?[k].sku == null ? '0' : "${finalCombinationsList[i].locationInventory?[k].sku}",
              "inventory[$k][barcode]": finalCombinationsList[i].locationInventory?[k].barcode == null ? '0' : "${finalCombinationsList[i].locationInventory?[k].barcode}",
            });

            if(finalCombinationsList[i].locationInventory?[k].inventoryId != null) {
              previousDetails.addAll({
                "inventory[$k][_id]": finalCombinationsList[i].locationInventory![k].inventoryId!,
            });
          }

          if (i == finalCombinationsList.length - 1 && k == finalCombinationsList[i].locationInventory!.length - 1) {
            for(int y = 0; y<= previousDetails.length-1; y++){
              print("${previousDetails.keys.elementAt(y)}: ${previousDetails.values.elementAt(y)}");
            }
            Get.to(() => AddProduct3View(), arguments: {
              'productDetails': previousDetails,
              'productImages': Get.arguments['productImages'],
              'cameFromProductList': cameFromProductList,
              'oldDetails' : oldDetails,
            });
          }
        }
        }
    } else {
      for (int i = 0; i <= listOfOptionsAdded.length - 1; i++) {
        previousDetails.addAll({
          "options[$i][name]": listOfOptionsAdded[i].optionName!.text,
        });
        for (int j = 0; j <= listOfOptionsAdded[i].optionValues!.length - 1; j++) {
          previousDetails.addAll({
            "options[$i][values][$j]":
            listOfOptionsAdded[i].optionValues![j].text
          });
        }
      }
      for (int i = 0; i <= finalCombinationsList.length - 1; i++) {
        previousDetails.addAll({
          "variants[$i][variantId]": "$i",
          "variants[$i][weight]": finalCombinationsList[i].weight == null ? '0' : '${finalCombinationsList[i].weight}',
          "variants[$i][dimensions][length]": finalCombinationsList[i].dimensions?.length == null ? '0' : '${finalCombinationsList[i].dimensions?.length}',
          "variants[$i][dimensions][width]": finalCombinationsList[i].dimensions?.width == null ? '0' : '${finalCombinationsList[i].dimensions?.width}',
          "variants[$i][dimensions][height]": finalCombinationsList[i].dimensions?.height == null ? '0' : '${finalCombinationsList[i].dimensions?.height}'
        });
        final split = finalCombinationsList[i].variantName?.split(' - ');
        if (split!.length > 1) {
          for (int j = 0; j <= split.length - 1; j++) {
            previousDetails.addAll({
              "variants[$i][options][$j]": split[j],
            });
          }
        } else {
          previousDetails.addAll({'variants[$i][options][0]': split[0]});
        }
        for (int k = 0; k <= finalCombinationsList[i].locationInventory!.length - 1; k++) {
          previousDetails.addAll({
            "inventory[$k][location]": finalCombinationsList[i].locationInventory![k].locationId!,
            "inventory[$k][variant]": '$i',
            "inventory[$k][quantity]": finalCombinationsList[i].locationInventory?[k].quantity == null ? '0' : "${finalCombinationsList[i].locationInventory![k].quantity!}",
            "inventory[$k][price]": finalCombinationsList[i].locationInventory?[k].price == null ? '0' : "${finalCombinationsList[i].locationInventory?[k].price}",
            "inventory[$k][sku]": finalCombinationsList[i].locationInventory?[k].sku == null ? '0' : "${finalCombinationsList[i].locationInventory?[k].sku}",
            "inventory[$k][barcode]": finalCombinationsList[i].locationInventory?[k].barcode == null ? '0' : "${finalCombinationsList[i].locationInventory?[k].barcode}",
          });
        }
        if (i == finalCombinationsList.length - 1) {
          Get.to(() => AddProduct3View(), arguments: {
            'productDetails': previousDetails,
            'productImages': Get.arguments['productImages'],
            'cameFromProductList': cameFromProductList,
          });
        }
      }
    }
  }
}