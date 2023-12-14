import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../helper/constants.dart';

class BankProfileViewModel extends GetxController {
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController cnicController = TextEditingController();
  RxString logoImage = ''.obs;
  RxBool logoImageErrorVisibility = false.obs;

  //Store Type ========
  RxList<String> bankList = [
    'select Your Bank',
    'UbL Bank,',
    'Sonehri Bank',
    'Meezaan Bank',
    'Telenor Micro Finance/Easypaisa',
    'Jazz Bank/Jazz Cash'
  ].obs;
  RxString selectedBank = 'select Your Bank'.obs;
  RxBool isChecked = false.obs;
  DropdownButton bankTypeDrowpDown() {
    return DropdownButton<String>(
      value: selectedBank.value.isNotEmpty ? selectedBank.value : "",
      items: bankList.map((String value) {
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
        selectedBank.value = val ?? "";
        print(
            "selected selected selectedBank Type====> $val  === ${selectedBank.value}");
      },
    );
  }
}
