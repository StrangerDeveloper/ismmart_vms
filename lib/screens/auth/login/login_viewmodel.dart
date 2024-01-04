import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ismmart_vms/widgets/custom_drawer.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../helper/api_base_helper.dart';
import '../../../helper/constants.dart';
import '../../../helper/global_variables.dart';
import '../../../helper/urls.dart';
import '../../drawer_bottom_nav/drawer_bottom_bar_view.dart';
import '../signup/account_status_view.dart';

class LogInViewModel extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  RxBool obscurePassword = true.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    // GlobalVariable.showLoader.value = false;
    super.onClose();
  }

  void signIn() {
    GlobalVariable.noInternet(false);
    if (signInFormKey.currentState?.validate() ?? false) {
      Map<String, dynamic> param = {
        "email": emailController.text,
        "password": passwordController.text,
      };

      GlobalVariable.showLoader.value = true;

      ApiBaseHelper()
          .postMethod(url: Urls.login, body: param)
          .then((parsedJson) async {
        if (parsedJson['success'] == true) {
          GlobalVariable.showLoader.value = false;
          GlobalVariable.token = parsedJson['data']['token'];
          String status = parsedJson['data']['status'] ?? "";
          accountStatusCheck(status, emailController.text);
        } else if (parsedJson['message'] == 'Invalid credentials') {
          AppConstant.displaySnackBar(
            "Error",
            "Wrong Credential",
          );

          GlobalVariable.showLoader.value = false;
        } else {
          AppConstant.displaySnackBar(
            " langKey.errorTitle.tr",
            parsedJson['message'],
          );

          GlobalVariable.showLoader.value = false;
        }
      }).catchError((e) {
        print(e);
        AppConstant.displaySnackBar(
          " langKey.errorTitle.tr",
          e.toString(),
        );
        GlobalVariable.showLoader.value = false;
      });
    }
  }

  final googleSignin = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  Future googleLogIn() async {
    GlobalVariable.showLoader.value = true;
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    GoogleSignInAccount? credential;
    try {
      // Get.to(DrawerBottomBarView());
      credential = await googleSignIn.signIn();
      credential?.authentication.then((value) async {
        print(credential);
        Map<dynamic, dynamic> param = {
          "social": {
            "name": "Google",
            "token": '${value.accessToken}',
          }
        };

        await ApiBaseHelper()
            .postMethod(url: Urls.login, body: param)
            .then((parsedJson) {
          if (parsedJson['success'] == true) {
            print(parsedJson['data']['status']);
            GlobalVariable.token = parsedJson['data']['token'];
            GlobalVariable.showLoader.value = false;
            //Get.offAll(DrawerBottomBarView());
          } else {
            GlobalVariable.showLoader.value = false;
          }
        });
      });
    } catch (error) {
      GlobalVariable.showLoader.value = false;
      //  debugPrint("$error");
    }
    update();
    // debugPrint("google signin Credential ===> ${credential}");
  }

//apple login
  appleSignin() async {
    if (Platform.isIOS) {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      debugPrint("apple login====>>>  $credential   ");

      // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
      // after they have been validated with Apple (see `Integration` section for more information on how to do this)
    }
  }

  resetValues() {
    emailController.clear();
    passwordController.clear();
  }

  // ----------  Status Enums Check of Account-------
  accountStatusCheck(String status, String email) {
    print(status);
    print(email);
    if (status == "Approved") {
      Get.offAll(() => DrawerBottomBarView());
    } else if (status == "Rejected") {
      var param = {
        'status': 'Rejected',
        'remarks': 'due to wrong id card',
        'email': ''
      };
      Get.offAll(() => AccountStatusView(), arguments: param);
    } else if (status == "Pending") {
      var param = {
        'status': 'Pending',
      };
      Get.offAll(() => AccountStatusView(), arguments: param);
    } else if (status == "Not Verified") {
      var param = {
        'status': 'Not Verified',
        'remarks': 'due to verify by your Gmail / Email Account',
        'email': '$email'
      };
      Get.offAll(() => AccountStatusView(), arguments: param);
    }
  }
}
