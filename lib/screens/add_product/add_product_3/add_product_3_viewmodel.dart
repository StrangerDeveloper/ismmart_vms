import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:ismmart_vms/helper/api_base_helper.dart';
import 'package:ismmart_vms/helper/constants.dart';
import 'package:ismmart_vms/helper/global_variables.dart';
import 'package:ismmart_vms/models/country_model.dart';
import 'package:ismmart_vms/screens/add_product/add_product_1/model/pictures_model.dart';
import 'package:ismmart_vms/screens/add_product/add_product_2/add_product_2_viewmodel.dart';
import 'package:ismmart_vms/screens/product_list/product_list_viewmodel.dart';
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
  Map<String, String> productDetails = {};
  List<PicturesModel> images = <PicturesModel>[];

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

  ///Variables for Country Field
  TextEditingController countryController = TextEditingController();
  RxInt countrySelected = 0.obs;
  RxList<CountryModel> countryList = <CountryModel>[].obs;

  bool cameFromProductList = false;

  @override
  void onInit() {
    productDetails = Get.arguments['productDetails'];
    images = Get.arguments['productImages'];
    cameFromProductList = Get.arguments['cameFromProductList'];
    getCountries();
    super.onInit();
  }

  @override
  void onReady() {
    weightUnitController.text = weightUnitList[weightUnitSelectedIndex.value];
    GlobalVariable.showLoader.value = true;
    super.onReady();
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

    final AddProduct2ViewModel addProduct2ViewModel = Get.find();
    for(int i = 0; i <= addProduct2ViewModel.finalCombinationsList.length-1 ; i++) {
      productDetails.addAll({
        "variants[$i][weight]": weightController.text,
        // "variants[$i][dimensions][length]": lengthController.text,
        // "variants[$i][dimensions][width]": widthController.text,
        // "variants[$i][dimensions][height]": heightController.text,
      });
    }
    List<http.MultipartFile> fileList = [];
    for(int i = 0; i<=images.length-1; i++){

      fileList.add(await http.MultipartFile.fromPath(
        'media[$i][file]', images[i].filePath!,
          contentType: MediaType.parse('image/*')
      ));
      productDetails.addAll({
        'media[$i][thumbnail]': "${images[i].thumbnail}"
      });
    }
    productDetails.addAll({
      'collections[0]': '657aa46a0f11b2ac3fc9285d'
    });

    await ApiBaseHelper().postMethodForImage(
        url: Urls.addProduct,
        files: fileList,
        fields: productDetails).then((parsedJson) async {
      GlobalVariable.showLoader.value = false;
      if(parsedJson['success'] == true) {
        if (cameFromProductList) {
          final ProductListViewModel productListViewModel = Get.find();
          productListViewModel.productItemsList.clear();
          await productListViewModel.getProductItems();
          productListViewModel.productItemsList.refresh();
          Get.close(2);
          AppConstant.displaySnackBar('Success', 'Product Added Successfully');
        } else {
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