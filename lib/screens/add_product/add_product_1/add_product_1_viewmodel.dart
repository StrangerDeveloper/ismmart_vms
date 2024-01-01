import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/api_base_helper.dart';
import 'package:ismmart_vms/screens/add_product/add_product_1/model/category_model.dart';
import 'package:ismmart_vms/screens/add_product/add_product_1/model/types_model.dart';
import 'package:ismmart_vms/widgets/widget_models/dropdown_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

class AddProduct1ViewModel extends GetxController {
  RxBool isPhysicalProduct = false.obs;
  TextEditingController prodTitleController = TextEditingController();
  TextEditingController prodDiscountController = TextEditingController();
  QuillEditorController prodDescriptionController = QuillEditorController();
  TextEditingController prodPriceController = TextEditingController();
  TextEditingController prodCompareAtPriceController = TextEditingController();
  TextEditingController prodCostPerItemController = TextEditingController();
  TextEditingController prodProfitController = TextEditingController();
  TextEditingController prodMarginController = TextEditingController();
  TextEditingController prodTagController = TextEditingController();

  FocusNode tagsFieldFocusNode = FocusNode();
  RxBool showTagsList = false.obs;
  RxBool chargeTaxOnProduct = true.obs;
  RxBool productPriceUpdate = false.obs;
  String productTypeId = '';
  RxString productCategory = '1'.obs;

  RxList<MultiSelectModel> tagsList = <MultiSelectModel>[
    MultiSelectModel(id: '1', name: 'Black'),
    MultiSelectModel(id: '2', name: 'Orange'),
    MultiSelectModel(id: '3', name: 'Shoes'),
    MultiSelectModel(id: '4', name: 'Belt'),
    MultiSelectModel(id: '5', name: 'Accessories'),
  ].obs;

  RxList<MultiSelectModel> searchedTags = <MultiSelectModel>[
    MultiSelectModel(id: '1', name: 'Black'),
    MultiSelectModel(id: '2', name: 'Orange'),
    MultiSelectModel(id: '3', name: 'Shoes'),
    MultiSelectModel(id: '4', name: 'Belt'),
    MultiSelectModel(id: '5', name: 'Accessories'),
  ].obs;

  RxList<MultiSelectModel> chosenTagsList = <MultiSelectModel>[].obs;
  RxList<MultiSelectModel> chosenCategoriesList = <MultiSelectModel>[].obs;
  RxList<MultiSelectModel> productCategoryList = <MultiSelectModel>[
    MultiSelectModel(id: '1', name: 'Select product category'),
    MultiSelectModel(id: '2', name: 'Vehicle'),
    MultiSelectModel(id: '3', name: 'Hardware'),
    MultiSelectModel(id: '4', name: 'Software'),
    MultiSelectModel(id: '5', name: 'Eatables'),
    MultiSelectModel(id: '6', name: 'Accessories'),
  ].obs;

  //type
  TextEditingController typeController = TextEditingController();
  RxInt typeSelectedIndex = 0.obs;
  RxList<TypesItem> typeList = <TypesItem>[].obs;

  //category
  TextEditingController categoryController = TextEditingController();
  RxInt categorySelectedIndex = 0.obs;
  //List<String> categoryList = const <String>['Dummy 1', 'Dummy 2', 'Dummy 3'];
  RxList<CategoryItem> categoryList = <CategoryItem>[].obs;

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
  RxInt priceAfterCommission = 1.obs;
  RxInt selectedCategoryID = 0.obs;
  RxInt selectedSubCategoryID = 1.obs;
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
  // Map<String, String>? categoryFieldList;

  var formKey = GlobalKey<FormState>();
  var formKeyCategoryField = GlobalKey<FormState>();
  var formPriceField = GlobalKey<FormState>();
  RxDouble imagesSizeInMb = 0.0.obs;
  RxBool uploadImagesError = false.obs;

  @override
  void onInit() async {
    await Permission.manageExternalStorage.request();
    super.onInit();
  }

  @override
  void onReady() {
    tagsFieldFocusNode.addListener(() {
      if (tagsFieldFocusNode.hasFocus) {
        showTagsList.value = true;
      } else {
        showTagsList.value = false;
        prodTagController.clear();
      }
    });
    fetchCategories();
    fetchTypes();
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

  void fetchTypes() async {
    // categoryList.clear();
    // categoriesList.insert(0, CategoryModel(name: chooseCategory.value, id: 0));
    await ApiBaseHelper().getMethod(url: '/public/type').then((parsedJson) {
      if (parsedJson['success'] == true) {
        //GlobalVariable.internetErr(false);
        var data = parsedJson['data'];
        TypesModel typesModel = TypesModel.fromJson(data);
        typeList.addAll(typesModel.items!);
      }
    }).catchError((e) {
      //GlobalVariable.internetErr(true);
      debugPrint("fetchTypes: $e");
    });
  }

  void fetchCategories() async {
    // categoryList.clear();
    // categoriesList.insert(0, CategoryModel(name: chooseCategory.value, id: 0));
    await ApiBaseHelper().getMethod(url: '/public/category').then((parsedJson) {
      if (parsedJson['success'] == true) {
        //GlobalVariable.internetErr(false);
        var data = parsedJson['data'];
        CategoryModel categoryModel = CategoryModel.fromJson(data);
        categoryList.addAll(categoryModel.items!);
      }
    }).catchError((e) {
      //GlobalVariable.internetErr(true);
      debugPrint("FetchCategories: $e");
    });
  }

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

  // void setDiscount(int? discount) {
  //   if (discount! > 0 && discount < 10) {
  //     discountMessage();
  //   } else if (discount > 90) {
  //     discountMessage();
  //   } else {
  //     discountMessage("");
  //   }
  // }

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
