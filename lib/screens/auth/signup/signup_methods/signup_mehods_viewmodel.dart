import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ismmart_vms/helper/languages/translations_key.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../../helper/api_base_helper.dart';
import '../../../../helper/global_variables.dart';
import '../../../../helper/urls.dart';
import '../../../dashboard/dashboard_view.dart';
import '../signup_1/sign_up_1_view.dart';

class SignupMehtodsViewModel extends GetxController {
  RxString socialName = ''.obs;
  RxString socialEmail = ''.obs;
  RxString socialToken = ''.obs;
  RxString socialPlatform = ''.obs;

  //----------Google singin---------
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
      credential = await googleSignIn.signIn();
      credential?.authentication.then((value) async {
        socialName.value = credential?.displayName ?? "";
        socialEmail.value = credential?.email ?? "";
        socialToken.value = '${value.accessToken}';
        socialPlatform.value = 'Google';
        GlobalVariable.showLoader.value = false;
        Get.to(() => SignUp1View());
        // Map<dynamic, dynamic> param = {
        //   "social": {
        //     "name": "Google",
        //     "token": '${value.accessToken}',
        //   }
        // };
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
}
