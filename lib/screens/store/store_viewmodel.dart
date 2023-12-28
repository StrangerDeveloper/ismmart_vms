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

  ////////////////////////
  RxBool shopImageErrorVisibility = false.obs;
  RxString shopLogoImage = ''.obs;

  selectImage(RxString imageVar, RxBool imageVisibilityVar) async {
    final image = await PickImage().pickSingleImage();
    if (image != null) {
      imageVar.value = image.path;
      imageVisibilityVar.value = false; //
    }
  }
////////////////////////
}
