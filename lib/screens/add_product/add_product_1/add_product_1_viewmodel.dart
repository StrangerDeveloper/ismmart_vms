import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/api_base_helper.dart';
import 'package:ismmart_vms/helper/constants.dart';
import 'package:ismmart_vms/helper/global_variables.dart';
import 'package:ismmart_vms/screens/add_product/add_product_1/model/pictures_model.dart';
import 'package:ismmart_vms/screens/add_product/add_product_1/model/bottom_sheet_item_model.dart';
import 'package:ismmart_vms/screens/add_product/add_product_2/add_product_2_view.dart';
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
  bool cameFromProductList = false;
  dynamic arguments;
  final GlobalKey<FormState> productDetailsFormKey = GlobalKey<FormState>();

  //Media
  RxList<PicturesModel> productImagesList = <PicturesModel>[].obs;
  RxBool productImagesUploadCheck = false.obs;
  RxBool imagesThumbnailCheck = false.obs;

  //tags
  RxList<BottomSheetItemModel> tagsList = <BottomSheetItemModel>[].obs;
  RxList<BottomSheetItemModel> chosenTagsList = <BottomSheetItemModel>[].obs;

  //categories
  RxInt selectedCategory = 0.obs;
  RxList<BottomSheetItemModel> chosenCategoriesList = <BottomSheetItemModel>[].obs;
  RxList<BottomSheetItemModel> productCategoryList = <BottomSheetItemModel>[].obs;

  //type
  TextEditingController typeController = TextEditingController();
  RxInt typeSelectedIndex = 0.obs;
  RxList<BottomSheetItemModel> typeList = <BottomSheetItemModel>[].obs;

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

  @override
  void onInit() async {
    await Permission.manageExternalStorage.request();
    arguments = Get.arguments;
    if(arguments != null) {
      cameFromProductList = arguments['cameFromProductList'];
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
    GlobalVariable.showLoader.value = false;
    super.onClose();
  }


  void fetchTypes() async {
    typeList.clear();
    await ApiBaseHelper().getMethod(url: '/public/type').then((parsedJson) {
      if (parsedJson['success'] == true) {
        var data = parsedJson['data']['items'] as List;
        if(data.isNotEmpty) {
          typeList.addAll(data.map((e) => BottomSheetItemModel.fromJson(e)));
        }
      }
    }).catchError((e) {
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
        }
      }
    }).catchError((e) {
      GlobalVariable.showLoader.value = false;
      AppConstant.displaySnackBar('Error', 'Product categories couldn\'t be fetched');
    });
  }

  proceed() async {
    if (productDetailsFormKey.currentState!.validate()) {
      if(productImagesList.isNotEmpty) {
        int index = productImagesList.indexWhere((element) => element.isThumbnail == true);
        if(index == -1){
          imagesThumbnailCheck.value = true;
        } else {
          Map<String, String> data = {};

          data.addAll({'name': prodTitleController.text});

          String description = await prodDescriptionController.getText();
          if (description != '') {
            data.addAll({'description': description});
          }

          for(int i = 0; i<=chosenCategoriesList.length-1 ; i++){
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
                      'cameFromProductList': cameFromProductList,
                    });
              }
            }
          } else {
                Get.to(() => AddProduct2View(), arguments: {
                  'productDetails': data,
                  'productImages': productImagesList,
                  'cameFromProductList': cameFromProductList,
                });
          }
        }
      } else {
        AppConstant.displaySnackBar('Error', 'Upload product image(s) to proceed');
      }
    } else {
      if(productImagesList.isEmpty) {
        productImagesUploadCheck.value = true;
      } else {
        int index = productImagesList.indexWhere((element) => element.isThumbnail == true);
        if(index == -1) {
          imagesThumbnailCheck.value = true;
        }
      }
    }
  }
}