import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../helper/api_base_helper.dart';
import '../../../helper/global_variables.dart';

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
  //
  // void signIn() {
  //   GlobalVariable.noInternet(false);
  //   if (signInFormKey.currentState?.validate() ?? false) {
  //     Map<String, dynamic> param = {
  //       "email": emailController.text,
  //       "password": passwordController.text,
  //     };
  //
  //     GlobalVariable.showLoader.value = true;
  //
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
  //
  //         GlobalVariable.showLoader.value = false;
  //       } else {
  //         AppConstant.displaySnackBar(
  //           langKey.errorTitle.tr,
  //           parsedJson['message'],
  //         );
  //
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

  final googleSignin = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  Future googleLogIn() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    GoogleSignInAccount? credential;
    try {
      credential = await googleSignIn.signIn();
      credential?.authentication.then((value) {
        print(value.idToken);
        print(value.accessToken);
      });
    } catch (error) {
      debugPrint("$error");
    }
    update();
    debugPrint("google signin Credential ===> $credential");
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
}
