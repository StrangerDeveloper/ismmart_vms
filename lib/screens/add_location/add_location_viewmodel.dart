import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddLocationViewModel extends GetxController {
  TextEditingController searchController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController statusController = TextEditingController();

  List<String> allCitiesList = [
    'Islamabad',
    'Rawalpindi',
    'Lahore',
    'Karachi',
    'Faisalabad',
    'Multan',
    'Sialkot',
    'Quetta',
    'Peshawar'
  ];

  List<String> allCountriesList = [
    'Pakistan',
    'UAE',
    'UK',
    'USA',
    'Sirilanka',
  ];

  List<String> filteredCitiesList = <String>[].obs;
  List<String> filteredCountriesList = <String>[].obs;
  RxInt statusSelectedIndex = 0.obs;
  List<String> statusList = const <String>['PKR', 'INR', 'DOLLAR'];

  @override
  void onReady() {
    filteredCitiesList.addAll(allCitiesList);
    filteredCountriesList.addAll(allCitiesList);
    super.onReady();
  }

  @override
  void onClose() {
    searchController.dispose();
    cityController.dispose();
    countryController.dispose();
    statusController.dispose();
    super.onClose();
  }

  resetValue({bool isCity = false}) {
    searchController.text = '';
    if (isCity) {
      filteredCitiesList.clear();
      filteredCitiesList.addAll(allCitiesList);
    } else {
      filteredCountriesList.clear();
      filteredCountriesList.addAll(allCountriesList);
    }
  }

  onSearch(String value, {bool isCity = false}) {
    if (isCity) {
      filteredCitiesList.clear();
      filteredCitiesList.addAll(allCitiesList
          .where((e) => e.toLowerCase().contains(value.toLowerCase())));
    } else {
      filteredCountriesList.clear();
      filteredCountriesList.addAll(allCountriesList
          .where((e) => e.toLowerCase().contains(value.toLowerCase())));
    }
  }
}
