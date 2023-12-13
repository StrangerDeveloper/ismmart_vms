import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/widget_models/dropdown_model.dart';

class ShippingViewModel extends GetxController {
  final shippingFormKey = GlobalKey<FormState>();

  List<DropDownModel> shippingMethodList = <DropDownModel>[
    DropDownModel(id: '1', name: 'LCS'),
    DropDownModel(id: '2', name: 'DHL'),
    DropDownModel(id: '3', name: 'TCS'),
  ].obs;

  var shippingMethod = "".obs;
}
