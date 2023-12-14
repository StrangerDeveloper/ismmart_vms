import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/widgets/widget_models/variant_options_field_model.dart';

class AddProductViewModel extends GetxController {
  TextEditingController prodNameController = TextEditingController();
  TextEditingController prodStockController = TextEditingController();
  TextEditingController prodBrandController = TextEditingController();
  TextEditingController prodDiscountController = TextEditingController();
  TextEditingController prodDescriptionController = TextEditingController();
  TextEditingController prodSKUController = TextEditingController();
  TextEditingController prodPriceController = TextEditingController();
  TextEditingController prodWeightController = TextEditingController();
  TextEditingController prodLengthController = TextEditingController();
  TextEditingController prodWidthController = TextEditingController();
  TextEditingController prodHeightController = TextEditingController();
  RxBool showVariantsField = false.obs;
  RxInt priceAfterCommission = 1.obs;
  RxInt selectedCategoryID = 0.obs;
  RxInt selectedSubCategoryID = 1.obs;
  RxList<String> optionsList = <String>["Size", "Color", "Material", "Style"].obs;
  RxString selectedOption = ''.obs;
  RxList<VariantsOptionsFieldModel> listOfOptionsAdded = <VariantsOptionsFieldModel>[
    // CustomDropDownList1(value: value, onChanged: onChanged, list: list)
  ].obs;
  // RxInt numberOfOptionsAdded = 0.obs;
  RxString chooseCategory = "Select Category".obs;
  RxString chooseSubCategory = "Select sub categories".obs;

  // Rx<SubCategory> selectedSubCategory = SubCategory().obs;
  // Rx<CategoryModel> selectedCategory = CategoryModel().obs;
  //
  // List<SubCategory> subCategoriesList = <SubCategory>[].obs;
  List<File> productImages = <File>[].obs;
  // List<CategoryModel> categoriesList = <CategoryModel>[].obs;
  // RxList<ProductVariantModel> productVariantsFieldsList = <ProductVariantModel>[].obs;
  List<List<String>> optionsAddedList = <List<String>>[];
  RxMap<String, dynamic> dynamicFieldsValuesList = <String, dynamic>{}.obs;
  Map<String, String>? categoryFieldList;

  var formKey = GlobalKey<FormState>();
  var formKeyCategoryField = GlobalKey<FormState>();

  RxString discountMessage = "".obs;
  RxDouble imagesSizeInMb = 0.0.obs;
  RxBool uploadImagesError = false.obs;
  double fieldsPaddingSpace = 12.0;
  RxBool isStockContainsInVariants = false.obs;

  @override
  void onReady() {
    // fetchCategories();
    // print('>>>Selected Category: ${selectedCategory.value.id}');
    super.onReady();
  }

  void onPriceFieldChange(String value) {
    if (value.isNotEmpty) {
      int amount = int.parse(value);
      priceAfterCommission(amount); // Updating priceAfterCommission directly
    } else {
      priceAfterCommission(0);
    }
  }

  creatingVariants() {
    List<String> combinations = [];
    if (listOfOptionsAdded.isNotEmpty) {
      if (listOfOptionsAdded.length > 1) {
        // int length = optionsAddedList.length - 1;
        int currentListIndex = 1;
        listOfOptionsAdded[0].optionValues?.forEach((element) {
          String name = element.text;
          if(listOfOptionsAdded[currentListIndex] == listOfOptionsAdded.last) {
            return;
          } else {
            listOfOptionsAdded[currentListIndex].optionValues?.forEach((listElement) {
              name = '$element - $listElement';
              combinations.add(name);
              if(listElement == listOfOptionsAdded[currentListIndex].optionValues?.last){
                combinations.forEach((element1) {print(element1);});
              }
            });
          }
        });
      }
    }
  }


  // createVariants() {
  //   List<List<String>> variantOptions = [
  //     ['Color', 'Red', 'Blue'],
  //     ['Size', 'Small', 'Medium', 'Large'],
  //     ['Material', 'Cotton', 'Polyester']
  //   ];
  //
  //   List<Map<String, String>> variantCombinations = generateVariantCombinations(variantOptions);
  //
  //   variantCombinations.forEach((variant) {
  //     print(variant);
  //   });
  // }
  //
  // List<Map<String, String>> generateVariantCombinations(List<List<String>> variantOptions) {
  //   List<Map<String, String>> combinations = [];
  //
  //   _generateCombinations(variantOptions, 0, {}, combinations);
  //
  //   return combinations;
  // }
  //
  // void _generateCombinations(
  //     List<List<String>> variantOptions,
  //     int index,
  //     Map<String, String> currentCombination,
  //     List<Map<String, String>> combinations,
  //     ) {
  //   if (index == variantOptions.length) {
  //     // Reached the end of options, add the current combination to the list
  //     combinations.add(Map.from(currentCombination));
  //     return;
  //   }
  //
  //   // Iterate through the options for the current variant
  //   for (int i = 1; i < variantOptions[index].length; i++) {
  //     // Clone the current combination to avoid modifying it for other iterations
  //     Map<String, String> updatedCombination = Map.from(currentCombination);
  //     updatedCombination[variantOptions[index][0]] = variantOptions[index][i];
  //
  //     // Recursively generate combinations for the next variant
  //     _generateCombinations(variantOptions, index + 1, updatedCombination, combinations);
  //   }
  // }


  // void onPriceFieldChange(String value) {
  //   if (value.isNotEmpty) {
  //     int amount = int.parse(value);
  //     int totalAfter = amount + (amount * 0.05).round();
  //     priceAfterCommission(totalAfter);
  //   } else {
  //     priceAfterCommission(0);
  //   }
  // }

  // void totalTax() {
  //   int price = int.parse(prodPriceController.text.toString());
  //   var a = (5 / 100) * price;
  //   priceAfterCommission.value = priceAfterCommission.value + a.toInt();
  // }

  // void fetchCategories() async {
  //   categoriesList.clear();
  //   categoriesList.insert(0, CategoryModel(name: chooseCategory.value, id: 0));
  //   await ApiBaseHelper().getMethod(url: 'category/all').then((parsedJson) {
  //     if (parsedJson['success'] == true) {
  //       GlobalVariable.internetErr(false);
  //       var parsedJsonData = parsedJson['data'] as List;
  //       categoriesList
  //           .addAll(parsedJsonData.map((e) => CategoryModel.fromJson(e)));
  //     }
  //   }).catchError((e) {
  //     GlobalVariable.internetErr(true);
  //     print(e);
  //   });
  // }

  // fetchSubCategories(int categoryID) async {
  //   await ApiBaseHelper()
  //       .getMethod(url: 'subcategory/$categoryID')
  //       .then((parsedJson) {
  //     if (parsedJson['success'] == true) {
  //       GlobalVariable.internetErr(false);
  //       var parsesJsonData = parsedJson['data'] as List;
  //       selectedSubCategory(SubCategory(name: chooseSubCategory.value, id: 0));
  //       subCategoriesList.insert(
  //           0, SubCategory(name: chooseSubCategory.value, id: 0));
  //       subCategoriesList
  //           .addAll(parsesJsonData.map((e) => SubCategory.fromJson(e)));
  //     }
  //   }).catchError((e) {
  //     GlobalVariable.internetErr(true);
  //
  //     print(e);
  //   });
  // }

  // void setSelectedCategory({CategoryModel? category}) async {
  //   selectedCategory.value = category!;
  //   if (!category.name!.contains(chooseCategory)) {
  //     dynamicFieldsValuesList.clear();
  //     selectedCategoryID(category.id!);
  //     subCategoriesList.clear();
  //     await fetchSubCategories(category.id!);
  //     //  await populateSubCategoriesList();
  //   }
  // }

  // void setSelectedSubCategory({SubCategory? subCategory}) {
  //   selectedSubCategory.value = subCategory!;
  //   if (!subCategory.name!.contains(chooseSubCategory)) {
  //     selectedSubCategoryID(subCategory.id!.isNaN ? 1 : subCategory.id!);
  //     getVariantsFields();
  //   }
  // }

  void setDiscount(int? discount) {
    if (discount! > 0 && discount < 10) {
      discountMessage();
    } else if (discount > 90) {
      discountMessage();
    } else {
      discountMessage("");
    }
  }

  // void getVariantsFields() async {
  //   ApiBaseHelper()
  //       .getMethod(
  //           url:
  //               'categoryFields?categoryId=$selectedCategoryID&subcategoryId=$selectedSubCategoryID')
  //       .then((parsedJson) {
  //     if (parsedJson['success'] == true) {
  //       GlobalVariable.internetErr(false);
  //       var parsedJsonData = parsedJson['data'] as List;
  //       productVariantsFieldsList.clear();
  //       productVariantsFieldsList.addAll(parsedJsonData
  //           .map((e) => ProductVariantsModel.fromJson(e))
  //           .toList());
  //     }
  //   }).catchError((e) {
  //     GlobalVariable.internetErr(true);
  //     print(e);
  //   });
  // }

  // void onDynamicFieldsValueChanged(String? value, ProductVariantsModel? model) {
  //   if (dynamicFieldsValuesList.containsValue(value))
  //     dynamicFieldsValuesList.removeWhere((key, v) => v == value);
  //   dynamicFieldsValuesList.addIf(
  //       !dynamicFieldsValuesList.containsValue(value), "${model!.id}", value);
  // }
  //
  // void addProdBtnPress() {
  //   GlobalVariable.internetErr(false);
  //   if (formKey.currentState!.validate()) {
  //     if (subCategoriesList.isNotEmpty) {
  //       if (discountMessage.isEmpty) {
  //         if (!uploadImagesError.value) {
  //           addProduct();
  //         } else {
  //           uploadImagesError.value = true;
  //         }
  //       } else {
  //         AppConstant.displaySnackBar(
  //           langKey.errorTitle,
  //           langKey.yourDiscountShould.tr,
  //         );
  //       }
  //     } else {
  //       AppConstant.displaySnackBar(
  //           langKey.errorTitle, langKey.plzSelectSubCategory.tr);
  //     }
  //   }
  // }
  //
  // void addProduct() async {
  //   GlobalVariable.showLoader.value = true;
  //   num discount = prodDiscountController.text.isEmpty
  //       ? 0
  //       : num.parse(prodDiscountController.text);
  //   ProductModel newProduct = ProductModel(
  //       name: prodNameController.text.trim(),
  //       price: priceAfterCommission.value,
  //       stock: int.parse(prodStockController.text),
  //       categoryId: selectedCategoryID.value,
  //       subCategoryId: selectedSubCategoryID.value,
  //       description: prodDescriptionController.text,
  //       weight: double.parse(prodWeightController.text),
  //       length: prodLengthController.text.isNotEmpty
  //           ? double.parse(prodLengthController.text)
  //           : null,
  //       width: prodWidthController.text.isNotEmpty
  //           ? double.parse(prodWidthController.text)
  //           : null,
  //       height: prodHeightController.text.isNotEmpty
  //           ? double.parse(prodHeightController.text)
  //           : null,
  //       discount: discount);
  //
  //   Map<String, String> body = {
  //     'name': newProduct.name.toString(),
  //     'price': newProduct.price.toString(),
  //     'stock': newProduct.stock.toString(),
  //     'categoryId': newProduct.categoryId.toString(),
  //     'subCategoryId': newProduct.subCategoryId.toString(),
  //     if (newProduct.discount != null &&
  //         newProduct.discount! >= 10 &&
  //         newProduct.discount! <= 90)
  //       'discount': newProduct.discount.toString(),
  //     'weight': newProduct.weight.toString(),
  //     if (newProduct.width != null) 'width': newProduct.width.toString(),
  //     if (newProduct.length != null) 'length': newProduct.length.toString(),
  //     if (newProduct.height != null) 'height': newProduct.height.toString(),
  //     'description': newProduct.description.toString(),
  //   };
  //
  //   if (dynamicFieldsValuesList.isNotEmpty) {
  //     for (int i = 0; i < dynamicFieldsValuesList.entries.length; i++) {
  //       body.addAll({
  //         'features[$i][id]':
  //             "${dynamicFieldsValuesList.entries.elementAt(i).key}",
  //         'features[$i][value]':
  //             "${dynamicFieldsValuesList.entries.elementAt(i).value}"
  //       });
  //     }
  //   } else {
  //     body.addAll({'features': '[]'});
  //   }
  //
  //   print(body);
  //
  //   List<http.MultipartFile> filesList = [];
  //   for (File image in productImages) {
  //     filesList.add(await http.MultipartFile.fromPath(
  //       'images',
  //       image.path,
  //       contentType: MediaType.parse('image/jpeg'),
  //     ));
  //   }
  //
  //   await ApiBaseHelper()
  //       .postMethodForImage(
  //     url: 'vendor/products/add',
  //     files: filesList,
  //     fields: body,
  //     withAuthorization: true,
  //   )
  //       .then((value) async {
  //     GlobalVariable.showLoader.value = false;
  //     if (value['success'] == true) {
  //       GlobalVariable.internetErr(false);
  //       MyProductsViewModel myProductsViewModel = Get.find();
  //       myProductsViewModel.loadInitialProducts();
  //
  //       Get.back();
  //       AppConstant.displaySnackBar(langKey.success.tr, value['message']);
  //     } else {
  //       debugPrint('Error: ${value.toString()}');
  //       GlobalVariable.internetErr(false);
  //
  //       AppConstant.displaySnackBar(
  //         langKey.errorTitle.tr,
  //         "${value['message'] != null ? value['message'] : langKey.someThingWentWrong.tr}",
  //       );
  //     }
  //   }).catchError((e) {
  //     GlobalVariable.internetErr(true);
  //     debugPrint('Error: ${e.toString()}');
  //     //   AppConstant.displaySnackBar(langKey.errorTitle, "${e.message}");
  //   });
  // }
}
