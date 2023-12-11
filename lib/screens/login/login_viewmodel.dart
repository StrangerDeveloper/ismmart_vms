import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogInViewModel extends GetxController {
  GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool obscurePassword = true.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    // GlobalVariable.showLoader.value = false;
    super.onClose();
  }

  // void signIn() {
  //   // GlobalVariable.internetErr(false);
  //   if (signInFormKey.currentState?.validate() ?? false) {
  //     Map<String, dynamic> param = {
  //       "email": emailController.text,
  //       "password": passwordController.text,
  //     };

  //     // GlobalVariable.showLoader.value = true;

  //     ApiBaseHelper()
  //         .postMethod(url: Urls.login, body: param)
  //         .then((parsedJson) async {
  //       if (parsedJson['success'] == true) {
  //         GlobalVariable.internetErr(false);
  //         authController.currUserToken.value = parsedJson['data']['token'];
  //         getCurrentUser(json: parsedJson);
  //       } else if (parsedJson['message'] == 'Invalid credentials') {
  //         AppConstant.displaySnackBar(
  //           langKey.errorTitle.tr,
  //           langKey.wrongWithCredentials.tr,
  //         );

  //         GlobalVariable.showLoader.value = false;
  //       } else {
  //         AppConstant.displaySnackBar(
  //           langKey.errorTitle.tr,
  //           parsedJson['message'],
  //         );

  //         GlobalVariable.showLoader.value = false;
  //       }
  //     }).catchError((e) {
  //       //  GlobalVariable.internetErr(true);
  //       AppConstant.displaySnackBar(
  //         langKey.errorTitle.tr,
  //         e,
  //       );
  //       print(e);
  //       GlobalVariable.showLoader.value = false;
  //     });
  //   }
  // }
}
