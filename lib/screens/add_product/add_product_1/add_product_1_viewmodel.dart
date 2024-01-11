import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/api_base_helper.dart';
import 'package:ismmart_vms/helper/constants.dart';
import 'package:ismmart_vms/helper/global_variables.dart';
import 'package:ismmart_vms/screens/add_product/add_product_1/model/pictures_model.dart';
import 'package:ismmart_vms/screens/add_product/add_product_1/model/bottom_sheet_item_model.dart';
import 'package:ismmart_vms/screens/add_product/add_product_2/add_product_2_view.dart';
import 'package:ismmart_vms/screens/product_list/single_product_model.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

class AddProduct1ViewModel extends GetxController {

  /// Variables for handling arguments
  RxBool cameFromProductList = false.obs;
  Map<String, dynamic> arguments = {};
  Rx<SingleProductModel> productDetails = SingleProductModel().obs;

  /// Controllers & Global Keys
  TextEditingController prodTitleController = TextEditingController();
  QuillEditorController prodDescriptionController = QuillEditorController();
  TextEditingController prodTagController = TextEditingController();
  final GlobalKey<FormState> productDetailsFormKey = GlobalKey<FormState>();

  ///Media
  RxList<PicturesModel> productImagesList = <PicturesModel>[].obs;
  RxBool productImagesUploadCheck = false.obs;
  RxBool imagesThumbnailCheck = false.obs;
  RxList<PicturesModel> addedImagesList = <PicturesModel>[].obs;

  ///tags
  RxList<BottomSheetItemModel> tagsList = <BottomSheetItemModel>[].obs;
  RxList<BottomSheetItemModel> chosenTagsList = <BottomSheetItemModel>[].obs;

  ///categories
  RxInt selectedCategory = 0.obs;
  RxList<BottomSheetItemModel> chosenCategoriesList = <BottomSheetItemModel>[].obs;
  RxList<BottomSheetItemModel> productCategoryList = <BottomSheetItemModel>[].obs;

  ///type
  TextEditingController typeController = TextEditingController();
  RxInt typeSelectedIndex = 0.obs;
  RxList<BottomSheetItemModel> typeList = <BottomSheetItemModel>[].obs;

  ///Refresh and Info change check variables
  RxBool typeRefreshCheck = false.obs;
  RxBool categoryRefreshCheck = false.obs;
  bool categoriesChanged = false;
  bool tagsChanged = false;
  bool imagesChanged = false;

  /// Description Field Tool Bar Functions
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

  ///General Variables
  SingleProductModel tempModel = SingleProductModel();

  @override
  void onInit() async {
    if(Get.arguments != null) {
      arguments = Get.arguments;
      if(arguments.containsKey('cameFromProductList')){
        cameFromProductList.value = arguments['cameFromProductList'];
      }
      if(arguments.containsKey('productDetails')){
        productDetails.value = arguments['productDetails'];
        tempModel = arguments['productDetails'];
        fillData();
      }
    }
    super.onInit();
  }

  @override
  void onReady() {
    // tagsFieldFocusNode.addListener(() {
    //   if (tagsFieldFocusNode.hasFocus) {
    //     showTagsList.value = true;
    //   } else {
    //     showTagsList.value = false;
    //     prodTagController.clear();
    //   }
    // });
    fetchCategories();
    fetchTypes();
    // fetchTags();
    super.onReady();
  }
  @override
  void onClose() {
    prodTitleController.dispose();
    prodDescriptionController.dispose();
    prodTagController.dispose();
    // GlobalVariable.showLoader.value = false;
    super.onClose();
  }

  fillData() async {
    prodTitleController.text = productDetails.value.name!;
    if(productDetails.value.description != null) {
      prodDescriptionController.insertText(productDetails.value.description!, index: 0);
    }
    typeSelectedIndex.value = typeList.indexWhere((element) => element.id == productDetails.value.type?.id);
    if(typeSelectedIndex.value == -1) {
      typeSelectedIndex.value = 0;
    }
    typeController.text = productDetails.value.type!.name!;
    for(var category in productDetails.value.categories!) {
      chosenCategoriesList.add(BottomSheetItemModel(
        id: category.id,
        name: category.name,
      ));
      productCategoryList.removeWhere((element) => element.id == category.id);
      productCategoryList.refresh();
    }
    for(var image in productDetails.value.media!) {
      productImagesList.add(PicturesModel(
        id: image.sId,
        url: image.url,
        type: image.type,
        thumbnail: image.thumbnail,
        fileName: image.url
      ));
      productImagesList.refresh();
    }
  }

  void fetchTypes() async {
    typeList.clear();
    await ApiBaseHelper().getMethod(url: '/public/type').then((parsedJson) {
      if (parsedJson['success'] == true) {
        var data = parsedJson['data']['items'] as List;
        if(data.isNotEmpty) {
          typeList.addAll(data.map((e) => BottomSheetItemModel.fromJson(e)));
          if(productDetails.value.type?.id != '' && productDetails.value.type?.id != null ) {
            int index = typeList.indexWhere((element) => element.id == productDetails.value.type?.id);
            if(index == -1) {
              return;
            } else {
              typeSelectedIndex.value = index;
            }
          }
        }
      }
    }).catchError((e) {
      typeRefreshCheck.value = true;
      AppConstant.displaySnackBar('Error', 'Product type couldn\'t be fetched');
    });
  }

  void fetchCategories() async {
    productCategoryList.clear();
    await ApiBaseHelper().getMethod(url: '/public/category').then((parsedJson) {
      if (parsedJson['success'] == true) {
        final data = parsedJson['data']['items'] as List;
        if(data.isNotEmpty) {
          productCategoryList.addAll(data.map((e) => BottomSheetItemModel.fromJson(e)));
          tagsList.addAll(data.map((e) => BottomSheetItemModel.fromJson(e)));
          if(cameFromProductList.value) {
            productDetails.value.categories?.forEach((element) {
              int index = productCategoryList.indexWhere((element1) => element1.id == element.id);
              chosenCategoriesList.add(BottomSheetItemModel(
                id: element.id,
                name: element.name,
                oldIndex: index
              ));
              productCategoryList.removeAt(index);
            });
          }
        }
      }
    }).catchError((e) {
      categoryRefreshCheck.value = true;
      GlobalVariable.showLoader.value = false;
      AppConstant.displaySnackBar('Error', 'Product categories couldn\'t be fetched');
    });
  }

  proceed() async {
    if (productDetailsFormKey.currentState!.validate()) {
      if(productImagesList.isNotEmpty) {
        int index = productImagesList.indexWhere((element) => element.thumbnail == true);
        if(index == -1){
          imagesThumbnailCheck.value = true;
        } else {
          if (cameFromProductList.value) {
            Map<String, String> data = {};

            data.addAll({'id': productDetails.value.sId!});

            data.addAll({'name': prodTitleController.text != productDetails.value.name ? prodTitleController.text : productDetails.value.name!});

            String description = await prodDescriptionController.getText();
            if (description != productDetails.value.description) {
              data.addAll({'description': description});
            }

            if(categoriesChanged) {
              for (int i = 0; i <= chosenCategoriesList.length - 1; i++) {
                data.addAll({
                  'categories[$i]': "${chosenCategoriesList[i].id}",
                });
              }
            }

            data.addAll({'type': typeList[typeSelectedIndex.value].id != productDetails.value.type?.id ? typeList[typeSelectedIndex.value].id! : productDetails.value.type!.id!});

            if (chosenTagsList.isNotEmpty) {
              if(tagsChanged) {
                for (int i = 0; i <= chosenTagsList.length - 1; i++) {
                  data.addAll({"tags[$i]": "${chosenTagsList[i].name}"});
                  if (i == chosenTagsList.length - 1) {
                    Get.to(() => AddProduct2View(), arguments: {
                      'productDetails': data,
                      'productImages': productImagesList,
                      'cameFromProductList': cameFromProductList.value,
                      'oldData': productDetails.value,
                    });
                  }
                }
              }
            } else {
              Get.to(() => AddProduct2View(), arguments: {
                'productDetails': data,
                'productImages': productImagesList,
                'cameFromProductList': cameFromProductList.value,
                'oldData': productDetails.value,
              });
            }
          } else {
            Map<String, String> data = {};

            data.addAll({'name': prodTitleController.text});

            String description = await prodDescriptionController.getText();
            if (description != '') {
              data.addAll({'description': description});
            }

            for (int i = 0; i <= chosenCategoriesList.length - 1; i++) {
              data.addAll({
                'categories[$i]': "${chosenCategoriesList[i].id}",
              });
            }

            data.addAll({'type': typeList[typeSelectedIndex.value].id!});

            if (chosenTagsList.isNotEmpty) {
              for (int i = 0; i <= chosenTagsList.length - 1; i++) {
                data.addAll({"tags[$i]": "${chosenTagsList[i].name}"});
                if (i == chosenTagsList.length - 1) {
                  Get.to(() => AddProduct2View(), arguments: {
                    'productDetails': data,
                    'productImages': productImagesList,
                    'cameFromProductList': cameFromProductList.value,
                  });
                }
              }
            } else {
              Get.to(() => AddProduct2View(), arguments: {
                'productDetails': data,
                'productImages': productImagesList,
                'cameFromProductList': cameFromProductList.value,
              });
            }
          }
        }
      } else {
        AppConstant.displaySnackBar('Error', 'Upload product image(s) to proceed');
      }
    } else {
      if(productImagesList.isEmpty) {
        productImagesUploadCheck.value = true;
      } else {
        int index = productImagesList.indexWhere((element) => element.thumbnail == true);
        if(index == -1) {
          imagesThumbnailCheck.value = true;
        }
      }
    }
  }
}