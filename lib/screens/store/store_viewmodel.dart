import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/pick_image.dart';

class StoreViewModel extends GetxController {
  GlobalKey<FormState> storeFormKey = GlobalKey<FormState>();
  TextEditingController storeNameController = TextEditingController();
  TextEditingController storeSlugController = TextEditingController();
  TextEditingController storeTypeController = TextEditingController();
  Rx<File> pickedFile = File('').obs;

}
