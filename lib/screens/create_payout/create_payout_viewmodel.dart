import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/widgets/widget_models/dropdown_model.dart';

class CreatePayoutViewModel extends GetxController {
  TextEditingController searchController = TextEditingController();
  TextEditingController vendorNameController = TextEditingController();
  TextEditingController currencyController = TextEditingController();
  TextEditingController paymentTypeController = TextEditingController();
  RxString transferMethodValue = '1'.obs;
  List<DropDownModel> transferMethodList = <DropDownModel>[
    DropDownModel(id: '1', name: 'Account No'),
    DropDownModel(id: '2', name: 'IBAN'),
  ].obs;

  RxString radioBtn = 'manual'.obs;

  RxInt currencySelectedIndex = 0.obs;
  RxInt paymentSelectedIndex = 0.obs;
  List<String> currencyList = const <String>[
    'PKR',
    'INR',
    'DOLLAR'
  ];

  List<String> paymentTypeList = const <String>[
    'Cash',
    'Card',
    'Online'
  ];

  List<String> allCitiesList = [
    'Faisal',
    'Ali',
    'Haider',
    'Hayat',
    'Mohsin',
    'Tahir',
    'Sahir',
    'Baber'
  ];
  List<String> filteredCitiesList = <String>[].obs;

  @override
  void onClose() {
    currencyController.dispose();
    searchController.dispose();
    vendorNameController.dispose();
    paymentTypeController.dispose();
    super.onClose();
  }

  resetValue() {
    searchController.text = '';
    filteredCitiesList.clear();
    filteredCitiesList.addAll(allCitiesList);
  }

  onSearch(String value) {
    filteredCitiesList.clear();
    filteredCitiesList.addAll(allCitiesList
        .where((e) => e.toLowerCase().contains(value.toLowerCase())));
  }
}
