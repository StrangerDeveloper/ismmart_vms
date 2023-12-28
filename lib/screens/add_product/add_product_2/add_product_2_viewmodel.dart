import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../models/variant_selection_model.dart';
import '../../../widgets/widget_models/dropdown_model.dart';
import '../../../widgets/widget_models/variant_options_field_model.dart';

class AddProduct2ViewModel extends GetxController {
  //RxList<String> optionsList = <String>["Size", "Color", "Material", "Style", "Other"].obs;
  //RxList<String> optionsChosen = <String>[].obs;
  //RxString selectedOption = ''.obs;
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
  RxList<DropDownModel> locationsList = <DropDownModel>[
    DropDownModel(id: '1', name: 'All Locations'),
    DropDownModel(id: '2', name: 'Safa Gold Mall'),
    DropDownModel(id: '3', name: 'Giga Mall'),
    DropDownModel(id: '4', name: 'Amanah Mall')
  ].obs;

  var variantsFormKey = GlobalKey<FormState>();

  @override
  void onReady() {
    scrollController.addListener(() {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        print('Reached max');
        listOfOptionsAdded.refresh();
      }
    });
    super.onReady();
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
        });
      }
    } else {
      print('Empty');
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
          }
        });
      });
    } else {
      combinations.forEach((element) {
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
            }
          }
        });
      });
    }
  }
}
