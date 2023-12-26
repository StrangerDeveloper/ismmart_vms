import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProduct3ViewModel extends GetxController{
  RxBool checkBoxIsPhysicalProduct = false.obs;
  RxBool checkBoxContinueSelling = false.obs;
  RxBool checkBoxSkuBarCode = false.obs;
  RxBool checkBoxOnlineStore = false.obs;
  RxBool checkBoxFbAndInstagram = false.obs;
  RxBool checkBoxEuropeInternational = false.obs;

  //category
  TextEditingController unitController = TextEditingController();
  RxInt unitSelectedIndex = 0.obs;
  List<String> unitList = const <String>[
    'Dummy 1',
    'Dummy 2',
    'Dummy 3'
  ];

}