import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:ismmart_vms/helper/api_base_helper.dart';
import 'package:ismmart_vms/helper/constants.dart';
import 'package:ismmart_vms/helper/global_variables.dart';
import 'package:ismmart_vms/models/country_model.dart';
import 'package:ismmart_vms/screens/add_product/add_product_1/model/pictures_model.dart';
import 'package:ismmart_vms/screens/product_list/product_list_viewmodel.dart';
import 'package:ismmart_vms/screens/product_list/single_product_model.dart';
import '../../../helper/urls.dart';

class AddProduct3ViewModel extends GetxController {

  RxBool checkBoxIsPhysicalProduct = true.obs;
  RxBool checkBoxContinueSelling = true.obs;
  RxBool checkBoxSkuBarCode = false.obs;
  RxBool checkBoxOnlineStore = false.obs;
  RxBool checkBoxFbAndInstagram = false.obs;
  RxBool checkBoxEuropeInternational = false.obs;
  RxBool productActiveStatusSwitch = true.obs;

  ///Data from previous screen
  Map<String, String> productDetailsToBeSent = {};
  List<PicturesModel> imagesToBeSent = <PicturesModel>[];

  ///Variables for Country Field
  TextEditingController countryController = TextEditingController();
  TextEditingController hsCodeController = TextEditingController();
  RxInt countrySelected = 0.obs;
  RxList<CountryModel> countryList = <CountryModel>[].obs;
  
  /// General Variables
  Map<String, dynamic> arguments = {};
  bool cameFromProductList = false;
  SingleProductModel oldDetails = SingleProductModel();
  RxBool editProduct = false.obs;

  @override
  void onInit() {
    if(Get.arguments != null) {
      arguments = Get.arguments;
      productDetailsToBeSent = Get.arguments['productDetails'];
      imagesToBeSent = Get.arguments['productImages'];
      cameFromProductList = Get.arguments['cameFromProductList'];
      if(arguments.containsKey('oldDetails')){
        oldDetails = arguments['oldDetails'];
        editProduct.value = true;
      }
      getCountries();
      super.onInit();
    }
  }

  @override
  void onReady() {
    GlobalVariable.showLoader.value = true;
    super.onReady();
  }

  fillData() {
  }

  getCountries() {
    ApiBaseHelper().getMethod(url: Urls.country).then((parsedJson) {
      GlobalVariable.showLoader.value = false;
      if(parsedJson['success'] == true) {
        final data = parsedJson['data']['items'] as List;
        if(data.isNotEmpty){
          countryList.addAll(data.map((e) => CountryModel.fromJson(e)));
          countryList.refresh();
          countrySelected.value = countryList.indexWhere((element) => element.name == 'Pakistan');
          countryController.text = countryList[countrySelected.value].name!;
        }
      }
    }).catchError((e) {
      GlobalVariable.showLoader.value = false;
      AppConstant.displaySnackBar('Error', e);
    });
  }

  addProduct() async {

    GlobalVariable.showLoader.value = true;

    List<http.MultipartFile> fileList = [];
    for(int i = 0; i<=imagesToBeSent.length-1; i++) {
      if (imagesToBeSent[i].url != null) {
        productDetailsToBeSent.addAll({
          'media[$i][_id]': imagesToBeSent[i].id!,
          'media[$i][thumbnail]' : "${imagesToBeSent[i].thumbnail}",
          'media[$i][url]': imagesToBeSent[i].url!,
        });
      } else {
        fileList.add(await http.MultipartFile.fromPath(
            'media[$i][file]', imagesToBeSent[i].filePath!,
            contentType: MediaType.parse('image/*')
        ));
        productDetailsToBeSent.addAll({
          'media[$i][thumbnail]': "${imagesToBeSent[i].thumbnail}"
        });
      }
    }
    productDetailsToBeSent.addAll({
      'collections[0]': '657aa46a0f11b2ac3fc9285d'
    });

    productDetailsToBeSent.addAll({
      'country': countryController.text,
    });

    productDetailsToBeSent.addAll({
      'hsCode': hsCodeController.text
    });

    if(editProduct.value){

      GlobalVariable.showLoader.value = false;

      await ApiBaseHelper().putMethodForImage(
          url: Urls.updateProduct + oldDetails.sId!,
          files: fileList,
          fields: productDetailsToBeSent
      ).then((parsedJson) async {
          if(parsedJson['success'] == true) {
            final ProductListViewModel productListViewModel = Get.find();
            productListViewModel.dataList.clear();
            productListViewModel.pageNo = 0;
            productListViewModel.currentPage.value = 0;
            await productListViewModel.getData();
            GlobalVariable.showLoader.value = false;
            productListViewModel.dataList.refresh();
            Get.close(3);
            AppConstant.displaySnackBar('Success', 'Product Added Successfully');
          }
      }).catchError((e) {
        print(e);
        GlobalVariable.showLoader.value = false;
      });
    } else {
      await ApiBaseHelper().postMethodForImage(
          url: Urls.addProduct,
          files: fileList,
          fields: productDetailsToBeSent).then((parsedJson) async {
        if(parsedJson['success'] == true) {
          if (cameFromProductList) {
            final ProductListViewModel productListViewModel = Get.find();
            productListViewModel.dataList.clear();
            productListViewModel.pageNo = 0;
            productListViewModel.currentPage.value = 0;
            await productListViewModel.getData();
            GlobalVariable.showLoader.value = false;
            productListViewModel.dataList.refresh();
            Get.close(3);
            AppConstant.displaySnackBar('Success', 'Product Added Successfully');
          } else {
            GlobalVariable.showLoader.value = false;
            GlobalVariable.selectedIndex.value = 0;
            Get.close(2);
            AppConstant.displaySnackBar('Success', 'Product Added Successfully');
          }
        }
      }).catchError((e) {
        GlobalVariable.showLoader.value = false;
        AppConstant.displaySnackBar('Error', e);
      });
    }
    }
  }