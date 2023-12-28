import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/models/category_model.dart';
import 'package:ismmart_vms/widgets/pick_image.dart';
import '../../../../helper/api_base_helper.dart';
import '../../../../helper/constants.dart';
import '../../../../helper/urls.dart';
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
  RxList<int> storeTypeList = <int>[].obs;
  RxBool countryErrorVisibility = false.obs;
  RxBool cityErrorVisibility = false.obs;
  RxBool storeTypeErrorVisibility = false.obs;
  RxList<CategoryModel> categoriesList = <CategoryModel>[].obs;

  @override
  void onInit() {
    getCountryList();
    geStoreTypeList();
    super.onInit();
  }

  selectImage(RxString imageVar, RxBool imageVisibilityVar) async {
    final image = await PickImage().pickSingleImage();
    if (image != null) {
      imageVar.value = image.path;
      imageVisibilityVar.value = false;
    }
  }

  //------------ Signup For Step 2 --------------
  List<http.MultipartFile> fileList = [];
  Future<void> signUpStep2() async {
    final SignUpScreen1ViewModel viewModel = Get.put(SignUpScreen1ViewModel());
    Map<String, String> param = Get.arguments;
    param['storeName'] = storeNameController.text;
    param['storeSlug'] = storeSlugController.text;
    param['storeTypes[0]'] = storeTypeSelectedId.value;
    param['country'] = selectedCountryId;
    param['city'] = selectedCityId;
    param['address'] = storeAddressController.text;
    param['step'] = '2';

    print(param);

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
      return AppConstant.displaySnackBar(
        " Error",
        " please upload Store Images",
      );
    }
    print("local list =====b${fileList.length}");

    var parsedJson = await ApiBaseHelper().postMethodForImage(
        url: Urls.register,
        withAuthorization: true,
        files: fileList,
        fields: param);

    if (parsedJson['success'] == true) {
      param.removeWhere((key, value) => value == "2");
      Get.to(() => SignUp3View(), arguments: param);
    } else {
      AppConstant.displaySnackBar(
        "Error",
        parsedJson['message'],
      );
    }
  }

  //-----------------Store Type Field Data------------
  //Store Type Data
  RxInt storeTypeSelectedIndex = 0.obs;
  RxString storeTypeSelectedId = ''.obs;
  List<String> typeList = [];
  List storeTypeIdList = [];
  Future<void> geStoreTypeList() async {
    typeList.clear();
    var parseJson = await ApiBaseHelper().getMethod(url: Urls.storeType);
    if (parseJson['success'] == true) {
      storeTypeIdList.clear();
      List rawList = parseJson['data']['items'];

      rawList.forEach((e) {
        typeList.add(e['name'].toString());
        storeTypeIdList.add(e['_id'].toString());
      });
      print(typeList);
      print(storeTypeIdList);
    }
  }

  //-----------------Country Field Data------------
  TextEditingController countryController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  List<String> allCountryList = [];
  List countryIdList = [];
  RxList<String> filteredCountryList = <String>[].obs;

  Future<void> getCountryList() async {
    var parseJson = await ApiBaseHelper().getMethod(url: Urls.country);
    if (parseJson['success'] == true) {
      allCountryList.clear();
      filteredCountryList.clear();
      List rawList = parseJson['data']['items'];

      rawList.forEach((e) {
        allCountryList.add(e['name'].toString());
        countryIdList.add(e['_id'].toString());
      });

      //print country with Id for Test------
      print(allCountryList);
      print(countryIdList);
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
    print("iiiiii ${i}    == $countryName ==== ${selectedCountryId}");
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
    var parseJson = await ApiBaseHelper()
        .getMethod(url: "/places/cities?limit=0&country=$countryId");
    if (parseJson['success'] == true) {
      allCityList.clear();
      filteredCityList.clear();
      List rawList = parseJson['data']['items'];

      rawList.forEach((e) {
        allCityList.add(e['name'].toString());
        cityIdList.add(e['_id'].toString());
      });
    }
  }

  onSearchCity(String value) {
    filteredCityList.clear();
    filteredCityList.addAll(allCountryList
        .where((e) => e.toLowerCase().contains(value.toLowerCase())));
  }

  String selectedCityId = '';
  getCityId(int index) {
    selectedCityId = cityIdList[index];
  }

  resetValueCity() {
    citySearchController.text = '';
    filteredCityList.clear();
    filteredCityList.addAll(allCityList);
  }
}
