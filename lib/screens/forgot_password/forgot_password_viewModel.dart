import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/api_base_helper.dart';
import 'package:ismmart_vms/helper/urls.dart';

import '../../helper/constants.dart';
import '../../helper/global_variables.dart';

class ForgotPasswordViewModel extends GetxController {
  GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  void onReady() {
    GlobalVariable.showLoader.value = false;
    emailController.text = Get.arguments['email'] ?? "test@gmail.com";
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    GlobalVariable.showLoader.value = false;
    super.onClose();
  }

  void sendBtn() async {
    if (forgotPasswordFormKey.currentState?.validate() ?? false) {
      Map<String, dynamic> param = {"email": emailController.text};
      print(param);
      GlobalVariable.showLoader.value = true;
      var parsedJson = await ApiBaseHelper()
          .postMethod(url: Urls.forgetPassword, body: param);
      print(parsedJson);

      if (parsedJson['success' == true]) {
        GlobalVariable.showLoader.value = false;
        return AppConstant.displaySnackBar(
          "Success",
          "Reset Password Link send to your Email",
        );
      } else {
        GlobalVariable.showLoader.value = false;
        return AppConstant.displaySnackBar(
          "Error",
          "resent to your Email",
        );
      }
    }
  }
}
