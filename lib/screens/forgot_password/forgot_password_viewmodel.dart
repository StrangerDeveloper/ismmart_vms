import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/api_base_helper.dart';
import 'package:ismmart_vms/helper/urls.dart';
import '../../helper/constants.dart';
import '../../helper/global_variables.dart';

class ForgotPasswordViewModel extends GetxController {
  GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  Map<String, dynamic> parsedJson = {};

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
      try {
        Map<String, dynamic> param = {"email": emailController.text};
        GlobalVariable.showLoader.value = true;
        parsedJson = await ApiBaseHelper()
            .postMethod(url: Urls.forgetPassword, body: param);

        if (parsedJson['success'] == true) {
          GlobalVariable.showLoader.value = false;
          AppConstant.displaySnackBar(
            "success",
            "Reset Password Link send to your Email",
          );
          Future.delayed(const Duration(seconds: 3), () => Get.back());
        } else {
          GlobalVariable.showLoader.value = false;
          AppConstant.displaySnackBar(
            "Error",
            "${parsedJson['message']}",
          );
        }
      } catch (e) {
        GlobalVariable.showLoader.value = false;
        AppConstant.displaySnackBar(
          "Error",
          "${parsedJson['message']}",
        );
      }
    }
  }
}
