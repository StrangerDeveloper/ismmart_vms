import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/global_variables.dart';
import 'package:ismmart_vms/screens/location_list/cities_model.dart';
import 'package:ismmart_vms/screens/location_list/countries_model.dart';

import '../../helper/api_base_helper.dart';
import '../../helper/common_function.dart';
import '../../helper/constants.dart';
import '../../helper/urls.dart';

class AddLocationViewModel extends GetxController {
  GlobalKey<FormState> addLocationFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  String selectedCityId = '';
  String selectedCountryId = '';

  //cities
  List<CitiesModel> allCitiesList = [];
  List<CitiesModel> filteredCitiesList = <CitiesModel>[].obs;

  //countries
  List<CountriesModel> allCountriesList = [];
  List<CountriesModel> filteredCountriesList = <CountriesModel>[].obs;

  //status
  RxInt statusSelectedIndex = (-1).obs;
  List<String> statusList = const <String>['Active', 'In-Active'];

  @override
  void onReady() {
    getCountries();
    super.onReady();
  }

  @override
  void onClose() {
    nameController.dispose();
    countryController.dispose();
    cityController.dispose();
    addressController.dispose();
    statusController.dispose();
    searchController.dispose();
    GlobalVariable.showLoader.value = false;
    super.onClose();
  }

  resetCitiesCountryValue({bool isCity = false}) {
    searchController.text = '';
    if (isCity) {
      filteredCitiesList.clear();
      filteredCitiesList.addAll(allCitiesList);
    } else {
      filteredCountriesList.clear();
      filteredCountriesList.addAll(allCountriesList);
    }
  }

  onSearchCitiesCountries(String value, {bool isCity = false}) {
    if (isCity) {
      filteredCitiesList.clear();
      filteredCitiesList.addAll(allCitiesList.where(
          (e) => e.name?.toLowerCase().contains(value.toLowerCase()) ?? false));
    } else {
      filteredCountriesList.clear();
      filteredCountriesList.addAll(allCountriesList.where(
          (e) => e.name?.toLowerCase().contains(value.toLowerCase()) ?? false));
    }
  }

  saveAndCreateBtn() async {
    if ((addLocationFormKey.currentState?.validate() ?? false) && statusSelectedIndex.value!=-1 && selectedCityId!='' && selectedCountryId!='') {
      GlobalVariable.showLoader.value = true;
      Map<String, String> param = {
        "name": nameController.text,
        "country": selectedCountryId,
        "city": selectedCityId,
        "address": addressController.text,
        "status": statusList[statusSelectedIndex.value],
        // "phone": nameController.text,
      };
      await ApiBaseHelper()
          .postMethod(url: Urls.addLocation, body: param)
          .then((parsedJson) {
        GlobalVariable.showLoader.value = false;
        if (parsedJson['success'] == true && parsedJson['message'] == 'Location added successfully') {
          Get.back();
        }
        AppConstant.displaySnackBar('Success', parsedJson['message']);

      }).catchError((e) {
        CommonFunction.debugPrint(e);
      });
    }
  }

  //////////////////////////////////////

  getCountries() async {
    await ApiBaseHelper().getMethod(url: Urls.getCountries).then((parsedJson) {
      if (parsedJson['success'] == true &&
          parsedJson['data']['items'] != null) {
        var data = parsedJson['data']['items'] as List;
        allCountriesList.addAll(data.map((e) => CountriesModel.fromJson(e)));
        filteredCountriesList.addAll(allCountriesList);
      }
    }).catchError((e) {
      CommonFunction.debugPrint(e);
    });
  }

  getCities(String countryName) async {
    GlobalVariable.showLoader.value = true;
    await ApiBaseHelper()
        .getMethod(url: '${Urls.getCities}$countryName')
        .then((parsedJson) {
      GlobalVariable.showLoader.value = false;
      if (parsedJson['success'] == true &&
          parsedJson['data']['items'] != null) {
        var data = parsedJson['data']['items'] as List;
        allCitiesList.addAll(data.map((e) => CitiesModel.fromJson(e)));
        filteredCitiesList.addAll(allCitiesList);
      }
    }).catchError((e) {
      CommonFunction.debugPrint(e);
    });
  }
}
