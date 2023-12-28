import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/pick_image.dart';

class StoreViewModel extends GetxController{
  GlobalKey<FormState> vendorSignUp2FormKey = GlobalKey<FormState>();
  TextEditingController storeNameController = TextEditingController();
  TextEditingController storeAddressController = TextEditingController();
  TextEditingController storeSlugController = TextEditingController();
  RxBool shopImageErrorVisibility = false.obs;
  RxString shopLogoImage = ''.obs;
  RxInt cityId = 0.obs;
  RxInt countryId = 0.obs;
  RxList<int> storeTypeList = <int>[].obs;
  RxBool countryErrorVisibility = false.obs;
  RxBool cityErrorVisibility = false.obs;
  RxBool storeTypeErrorVisibility = false.obs;
  selectImage(RxString imageVar, RxBool imageVisibilityVar) async {
    final image = await PickImage().pickSingleImage();
    if (image != null) {
      imageVar.value = image.path;
      imageVisibilityVar.value = false; //
    }
  }
}