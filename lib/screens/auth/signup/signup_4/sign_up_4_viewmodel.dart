import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../helper/api_base_helper.dart';
import '../../../../helper/constants.dart';
import '../../../../helper/global_variables.dart';
import '../../../../helper/urls.dart';

class SignUp4ViewModel extends GetxController {
  RxMap<String, String> status = <String, String>{}.obs;
  TextEditingController emailController = TextEditingController();
  Map<String, dynamic> parsedJson = {};

  @override
  void onInit() async {
    status.value = Get.arguments ?? {};
    super.onInit();
  }

  void resentEmail() async {
    try {
      Map<String, dynamic> param = {"email": "${status['email']}"};
      GlobalVariable.showLoader.value = true;
      parsedJson =
          await ApiBaseHelper().postMethod(url: Urls.resendEmail, body: param);

      if (parsedJson['success'] == true) {
        GlobalVariable.showLoader.value = false;
        AppConstant.displaySnackBar(
          "success",
          "Reset Password Link send to your Email",
        );
      } else {
        GlobalVariable.showLoader.value = false;
        AppConstant.displaySnackBar(
          "Error",
          "Failed To Send Email",
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
