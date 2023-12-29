import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
class StoreProfileViewModel extends GetxController {
  GlobalKey<FormState> storeFormKey = GlobalKey<FormState>();
  TextEditingController storeNameController = TextEditingController();
  TextEditingController storeSlugController = TextEditingController();
  TextEditingController storeTypeController = TextEditingController();
  Rx<File> pickedFile = File('').obs;

}
