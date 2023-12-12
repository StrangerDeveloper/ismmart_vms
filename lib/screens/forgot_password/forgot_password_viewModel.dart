import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:ism_mart/exports/exports_utils.dart';
// import 'package:ism_mart/helper/api_base_helper.dart';
// import 'package:ism_mart/helper/global_variables.dart';
// import 'package:ism_mart/helper/urls.dart';

import '../../helper/global_variables.dart';

class ForgotPasswordViewModel extends GetxController {
  GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  void onInit() {
    emailController.text = Get.arguments['email'];
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    GlobalVariable.showLoader.value = false;
    super.onClose();
  }

  void sendBtn() {
    if (forgotPasswordFormKey.currentState?.validate() ?? false) {
      Map<String, dynamic> param = {"email": emailController.text};

      GlobalVariable.showLoader.value = true;

      print(param);
      // ApiBaseHelper()
      //     .postMethod(url: Urls.forgetPassword, body: param)
      //     .then((parsedJson) async {
      //   GlobalVariable.showLoader.value = false;

      //   if (parsedJson['success'] == true) {
      //     Get.offNamed(Routes.forgotPassword2,
      //         arguments: {'email': emailController.text});
      //     AppConstant.displaySnackBar(
      //       langKey.successTitle.tr,
      //       parsedJson['message'],
      //     );
      //   } else if (parsedJson['message'] == 'Invalid credentials') {
      //     AppConstant.displaySnackBar(
      //       langKey.errorTitle.tr,
      //       langKey.wrongWithCredentials.tr,
      //     );
      //   } else {
      //     AppConstant.displaySnackBar(
      //       langKey.errorTitle.tr,
      //       parsedJson['message'],
      //     );
      //   }
      // }).catchError((e) {
      //   print(e);
      //   GlobalVariable.showLoader.value = false;
      // });
    }
  }
}
