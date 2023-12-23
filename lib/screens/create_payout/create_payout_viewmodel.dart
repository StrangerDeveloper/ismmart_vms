import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/widgets/widget_models/dropdown_model.dart';

class CreatePayoutViewModel extends GetxController {

  TextEditingController currencyController = TextEditingController();
  RxString transferMethodValue = '1'.obs;
  List<DropDownModel> transferMethodList = <DropDownModel>[
    DropDownModel(id: '1', name: 'Account No'),
    DropDownModel(id: '2', name: 'IBAN'),
  ].obs;

  RxString radioBtn = 'manual'.obs;

  RxInt currencySelectedIndex = 0.obs;
  List<String> currencyList = const <String>[
    'Select Type',
    'PKR',
    'INR',
    'DOLLAR'
  ];

  @override
  void onClose() {
    currencyController.dispose();
    super.onClose();
  }

}
