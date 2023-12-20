import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/models/variant_selection_model.dart';
import 'package:ismmart_vms/widgets/widget_models/dropdown_model.dart';
import 'package:ismmart_vms/widgets/widget_models/variant_options_field_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

class AddProductViewModel extends GetxController {
  TextEditingController prodTitleController = TextEditingController();
  TextEditingController prodStockController = TextEditingController();
  TextEditingController prodBrandController = TextEditingController();
  TextEditingController prodDiscountController = TextEditingController();
  QuillEditorController prodDescriptionController = QuillEditorController();
  TextEditingController prodSKUController = TextEditingController();
  TextEditingController prodPriceController = TextEditingController();
  TextEditingController prodCompareAtPriceController = TextEditingController();
  TextEditingController prodCostPerItemController = TextEditingController();
  TextEditingController prodProfitController = TextEditingController();
  TextEditingController prodMarginController = TextEditingController();
  TextEditingController prodWeightController = TextEditingController();
  TextEditingController prodLengthController = TextEditingController();
  TextEditingController prodWidthController = TextEditingController();
  TextEditingController prodHeightController = TextEditingController();
  RxBool showVariantsField = false.obs;
  RxBool showVariantsTable = false.obs;
  RxBool chargeTaxOnProduct = false.obs;
  RxList<DropDownModel> locationsList = <DropDownModel>[
    DropDownModel(
      id: '1',
      name: 'All Locations'
    ),
    DropDownModel(
      id: '2',
      name: 'Safa Gold Mall'
    ),
    DropDownModel(
      id: '3',
      name: 'Giga Mall'
    ),
    DropDownModel(
      id: '4',
      name: 'Amanah Mall'
    )
  ].obs;
  final customToolBarList = [
    ToolBarStyle.bold,
    ToolBarStyle.italic,
    ToolBarStyle.align,
    ToolBarStyle.color,
    ToolBarStyle.background,
    ToolBarStyle.listBullet,
    ToolBarStyle.listOrdered,
    ToolBarStyle.clean,
    ToolBarStyle.addTable,
    ToolBarStyle.editTable,
  ];
  RxString locationSelected = ''.obs;
  RxInt priceAfterCommission = 1.obs;
  RxInt selectedCategoryID = 0.obs;
  RxInt selectedSubCategoryID = 1.obs;
  RxList<String> optionsList = <String>["Size", "Color", "Material", "Style", "Other"].obs;
  RxList<String> optionsChosen = <String>[].obs;
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
  RxMap<String, dynamic> dynamicFieldsValuesList = <String, dynamic>{}.obs;
  Map<String, String>? categoryFieldList;
  List<String> combinations = [];
  RxList<VariantSelectionModel> finalCombinationsList = <VariantSelectionModel>[].obs;
  List<String> combinations2 = [];

  var formKey = GlobalKey<FormState>();
  var formKeyCategoryField = GlobalKey<FormState>();

  RxString discountMessage = "".obs;
  RxDouble imagesSizeInMb = 0.0.obs;
  RxBool uploadImagesError = false.obs;
  double fieldsPaddingSpace = 12.0;
  RxBool isStockContainsInVariants = false.obs;

  @override
  void onInit() async {
    await Permission.manageExternalStorage.request();
    super.onInit();
  }

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
    combinations.clear();
    if (listOfOptionsAdded.isNotEmpty) {
      if (listOfOptionsAdded.length > 1) {
          variantsFunction(0, 1);
      } else {
        combinations.clear();
        listOfOptionsAdded[0].optionValues?.forEach((element) {
          finalCombinationsList.add(VariantSelectionModel(variantName: element.text, variantSelected: false));
          finalCombinationsList.refresh();
        });
      }
    } else{
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
          if(element == listOfOptionsAdded[0].optionValues?.last && element2 == listOfOptionsAdded[1].optionValues?.last && nextIndex != listOfOptionsAdded.length-1) {
            variantsFunction(initialIndex + 1, nextIndex + 1);
          } else {
            finalCombinationsList.clear();
            finalCombinationsList.addAll(combinations2.map((e) => VariantSelectionModel(variantSelected: false, variantName: e)));
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
          if (element == combinations.last && listElement == listOfOptionsAdded[nextIndex].optionValues?.last) {
              combinations2.addAll(tempCombinations.map((e) => e));
              if(nextIndex != listOfOptionsAdded.length-1) {
                variantsFunction(initialIndex + 1, nextIndex + 1);
              } else {
                finalCombinationsList.clear();
                finalCombinationsList.addAll(tempCombinations.map((e) => VariantSelectionModel(variantName: e, variantSelected: false)));
                finalCombinationsList.refresh();
              }
          }
        });
      });
    }
  }

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
