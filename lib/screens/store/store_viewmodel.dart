import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../helper/constants.dart';
import '../../widgets/pick_image.dart';

class StoreViewModel extends GetxController {
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController cnicController = TextEditingController();
  RxString logoImage = ''.obs;
  RxBool logoImageErrorVisibility = false.obs;

  selectImage(RxString imageVar, RxBool imageVisibilityVar) async {
    final image = await PickImage().pickSingleImage();
    if (image != null) {
      imageVar.value = image.path;
      imageVisibilityVar.value = false;
    }
  }

  //Store Type ========
  RxList<String> storeTypes = [
    'select Store Type',
    'Accesaries,',
    'Clothing',
    'Shirts',
    'Pents',
    'Bags'
  ].obs;
  RxString selectedStoreType = 'select Store Type'.obs;
  RxBool isChecked = false.obs;
  DropdownButton storeTypeDrowpDown() {
    return DropdownButton<String>(
      value: selectedStoreType.value.isNotEmpty ? selectedStoreType.value : "",
      items: storeTypes.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            overflow: TextOverflow.ellipsis,
            value,
            style: GoogleFonts.dmSans(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: newColorDarkBlack2,
            ),
          ),
        );
      }).toList(),
      onChanged: (String? val) {
        selectedStoreType.value = val ?? "";
        print(
            "selected selected Store Type====> $val  === ${selectedStoreType.value}");
      },
    );
  }

  //Multiple select
  RxList<String> hobbyList = [
    'Shopping',
    'Comedy',
    'Brunch',
    'Music',
    'Road Trips',
    'Tea',
    'Trivia',
    'Comedy',
    'Clubbing',
    'Drinking',
    'Wine',
    'Hiking',
    'Yoga',
    'Volleyball',
    'Craft Beer',
    'Dogs',
    'Cats',
    'Activism',
    'Vlogging',
    'Museum',
    'Dancing',
    'Running',
    'Singing',
    'Make-Up',
    'Concert',
    'Cafe',
    'Theater',
    'Baking',
    'Gardening',
    'Cooking',
    'Video Games',
    'Camping'
  ].obs;

  RxList<String>? selectedHobby = [''].obs;
  RxBool isSelected = false.obs;
}
