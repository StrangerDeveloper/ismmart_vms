import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/global_variables.dart';
import '../../widgets/widget_models/dropdown_model.dart';

class ShippingViewModel extends GetxController {
  final shippingFormKey = GlobalKey<FormState>();

  List<DropDownModel> shippingMethodList = <DropDownModel>[
    DropDownModel(id: '1', name: 'LCS'),
    DropDownModel(id: '2', name: 'DHL'),
    DropDownModel(id: '3', name: 'TCS'),
  ].obs;

  List<DropDownModel> ratesTypeList = <DropDownModel>[
    DropDownModel(id: '1', name: 'Weight'),
    DropDownModel(id: '2', name: 'Price'),
    DropDownModel(id: '3', name: 'Distance'),
  ].obs;

  var shippingMethod = "1".obs;
  var ratesType = "1".obs;

  @override
  void onClose() {
    GlobalVariable.showLoader.value = false;
    super.onClose();
  }
}
