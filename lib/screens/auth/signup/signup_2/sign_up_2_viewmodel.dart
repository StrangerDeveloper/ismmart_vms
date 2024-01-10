import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/models/category_model.dart';
import 'package:ismmart_vms/widgets/pick_image.dart';
import '../../../../helper/api_base_helper.dart';
import '../../../../helper/common_function.dart';
import '../../../../helper/constants.dart';
import '../../../../helper/global_variables.dart';
import '../../../../helper/urls.dart';
import '../../../store_profile/store_type_model.dart';
import '../signup_1/sign_up_1_viewmodel.dart';
import '../signup_3/sign_up_3_view.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class SignUp2ViewModel extends GetxController {
  GlobalKey<FormState> vendorSignUp2FormKey = GlobalKey<FormState>();
  TextEditingController storeNameController = TextEditingController();
  TextEditingController storeSlugController = TextEditingController();
  TextEditingController storeTypeController = TextEditingController();
  TextEditingController storeAddressController = TextEditingController();
  RxString shopLogoImage = ''.obs;
  RxBool shopImageErrorVisibility = false.obs;
  RxInt cityId = 0.obs;
  RxInt countryId = 0.obs;
  // RxList<int> storeTypeList = <int>[].obs;
  RxBool countryErrorVisibility = false.obs;
  RxBool cityErrorVisibility = false.obs;
  RxBool storeTypeErrorVisibility = false.obs;
  RxList<CategoryModel> categoriesList = <CategoryModel>[].obs;

  selectImage(RxString imageVar, RxBool imageVisibilityVar) async {
    final image = await PickImage().pickSingleImage();
    if (image != null) {
      imageVar.value = image.path;
      imageVisibilityVar.value = false;
    }
  }

  //------------ Signup For Step 2 --------------
  final SignUpScreen1ViewModel viewModel = Get.put(SignUpScreen1ViewModel());
  RxBool storeErrorMsg = false.obs;
  List<http.MultipartFile> fileList = [];
  Future<void> signUpStep2() async {
    imgCheck();
    if (vendorSignUp2FormKey.currentState?.validate() ??
        false ||
            shopImageErrorVisibility.value ||
            storeErrorMsg.value == true) {
      GlobalVariable.showLoader.value = true;
      fileList.clear();
      Map<String, String> param = Get.arguments;
      param['storeName'] = storeNameController.text;
      param['storeSlug'] = storeSlugController.text;
      int index = 0;
      for (int i = 0; i < storeTypeList.length; i++) {
        if (storeTypeList[i].isSelected == true) {
          param["storeTypes[${index++}]"] = storeTypeList[i].sId!;
        }
      }
      param['country'] = selectedCountryId;
      param['city'] = selectedCityId.value;
      param['address'] = storeAddressController.text.toString();
      param['step'] = '2';

      // cnicBackImage.value

      if (shopLogoImage.value.isNotEmpty) {
        fileList.add(
          await http.MultipartFile.fromPath(
            'cnicImages',
            viewModel.cnicFrontImage.value,
            contentType: MediaType.parse('image/jpeg'),
          ),
        );
        fileList.add(
          await http.MultipartFile.fromPath(
            'cnicImages',
            viewModel.cnicBackImage.value,
            contentType: MediaType.parse('image/jpeg'),
          ),
        );
        fileList.add(
          await http.MultipartFile.fromPath(
            'storeImage',
            shopLogoImage.value,
            contentType: MediaType.parse('image/jpeg'),
          ),
        );
      } else {
        GlobalVariable.showLoader.value = false;
        return AppConstant.displaySnackBar(
          " Error",
          " please upload Store Images",
        );
      }
      GlobalVariable.showLoader.value = true;
      var parsedJson = await ApiBaseHelper().postMethodForImage(
          url: Urls.register, files: fileList, fields: param);

      if (parsedJson['success'] == true) {
        GlobalVariable.showLoader.value = false;
        param.removeWhere((key, value) => value == "2");
        Get.to(() => SignUp3View(), arguments: param);
      } else {
        GlobalVariable.showLoader.value = false;
        AppConstant.displaySnackBar(
          "Error",
          parsedJson['message'],
        );
      }
    }
  }

  imgCheck() {
    if (shopLogoImage.value.isEmpty) {
      shopImageErrorVisibility.value = true;
    }
    if (storeTypeList.where((element) => element.isSelected == true).isEmpty) {
      storeErrorMsg.value = true;
    }
  }

  //-----------------Store Type Field Data------------
  //Store Type Data
  //-----------------Store Type Field Data------------
  List<StoreTypeModel> storeTypeList = <StoreTypeModel>[].obs;
  RxBool selectAllValue = false.obs;
  selectAllItems() {
    selectAllValue.value = !selectAllValue.value;
    for (int i = 0; i < storeTypeList.length; i++) {
      StoreTypeModel model1 = storeTypeList[i];
      model1.isSelected = selectAllValue.value;
      storeTypeList[i] = model1;
    }
  }

  selectSingleItem(bool value, int index) {
    StoreTypeModel model1 = storeTypeList[index];
    model1.isSelected = value;
    storeTypeList[index] = model1;
    storeErrorMsg.value = false;
  }

  getStoreTypes() async {
    GlobalVariable.showLoader.value = true;
    await ApiBaseHelper().getMethod(url: Urls.getStoreType).then((parsedJson) {
      GlobalVariable.showLoader.value = false;
      if (parsedJson['success'] == true &&
          parsedJson['data']['items'] != null) {
        var data = parsedJson['data']['items'] as List;
        storeTypeList.addAll(data.map((e) => StoreTypeModel.fromJson(e)));
      }
    }).catchError((e) {
      CommonFunction.debugPrint(e);
    });
  }

  //-----------------Country Field Data------------
  TextEditingController countryController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  List<String> allCountryList = [];
  List countryIdList = [];
  RxList<String> filteredCountryList = <String>[].obs;

  Future<void> getCountryList() async {
    GlobalVariable.showLoader(true);
    var parseJson = await ApiBaseHelper().getMethod(url: Urls.country);
    if (parseJson['success'] == true) {
      GlobalVariable.showLoader(false);
      allCountryList.clear();
      filteredCountryList.clear();
      List rawList = parseJson['data']['items'];

      for (var e in rawList) {
        allCountryList.add(e['name'].toString());
        countryIdList.add(e['_id'].toString());
      }
      GlobalVariable.showLoader.value = false;
      //print country with Id for Test------
    } else {
      GlobalVariable.showLoader(false);
    }
  }

  onSearch(String value) {
    filteredCountryList.clear();
    filteredCountryList.addAll(allCountryList
        .where((e) => e.toLowerCase().contains(value.toLowerCase())));
  }

  String selectedCountryId = '';
  getCountryId(String countryName) async {
    selectedCountryId = '';

    int i = allCountryList.indexWhere((e) => e == countryName);
    selectedCountryId = countryIdList[i];
    await getCityList(selectedCountryId);
  }

  resetValue() {
    searchController.text = '';
    filteredCountryList.clear();
    filteredCountryList.addAll(allCountryList);
  }

  //-----------------City Field Data------------
  TextEditingController cityController = TextEditingController();
  TextEditingController citySearchController = TextEditingController();
  List<String> allCityList = [];
  List cityIdList = [];
  RxList<String> filteredCityList = <String>[].obs;

  Future<void> getCityList(String countryId) async {
    GlobalVariable.showLoader(true);
    var parseJson = await ApiBaseHelper()
        .getMethod(url: "/places/cities?limit=0&country=$countryId");
    if (parseJson['success'] == true) {
      GlobalVariable.showLoader.value == false;
      allCityList.clear();
      filteredCityList.clear();
      List rawList = parseJson['data']['items'];

      for (var e in rawList) {
        allCityList.add(e['name'].toString());
        cityIdList.add(e['_id'].toString());
      }
      GlobalVariable.showLoader(false);
    } else {
      GlobalVariable.showLoader(false);
    }
  }

  onSearchCity(String value) {
    filteredCityList.clear();
    filteredCityList.addAll(allCityList
        .where((e) => e.toLowerCase().contains(value.toLowerCase())));
  }

  RxString selectedCityId = ''.obs;

  getCityId(String cityname) async {
    selectedCityId.value = '';

    int i = allCityList.indexWhere((e) => e == cityname);
    selectedCityId.value = cityIdList[i];
  }

  resetValueCity() {
    citySearchController.text = '';
    filteredCityList.clear();
    filteredCityList.addAll(allCityList);
  }

  @override
  void onReady() {
    GlobalVariable.showLoader.value = false;
    getCountryList();
    getStoreTypes();
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    GlobalVariable.showLoader.value = false;
    // TODO: implement onClose
    super.onClose();
  }
}
