import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/global_variables.dart';

class LogInViewModel extends GetxController {
  GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool obscurePassword = true.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    GlobalVariable.showLoader.value = false;
    super.onClose();
  }

// void signIn() {
//   GlobalVariable.internetErr(false);
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
//
// static void getCurrentUser({Map<String, dynamic>? json}) async {
//   await ApiBaseHelper()
//       .getMethod(url: 'user/profile', withAuthorization: true)
//       .then((value) async {
//     if (value['success'] == true) {
//       UserResponse userResponse = UserResponse.fromResponse(value);
//       userResponse.userModel!.token = json?['data']['token'];
//
//       GlobalVariable.userModel = userResponse.userModel;
//       authController.setUserModel(userResponse.userModel);
//       SettingViewModel settingViewModel = Get.find();
//       settingViewModel.setUserModel(userResponse.userModel);
//       baseController.changePage(0);
//       Get.back();
//       await LocalStorageHelper.storeUser(userModel: userResponse.userModel)
//           .then((value) {});
//       // print('>>User Model: ${userResponse.userModel}');
//       AppConstant.displaySnackBar(
//         langKey.successTitle.tr,
//         json?['message'],
//       );
//     }
//   });
// }
//
// //Apple Signin
// String generateNonce([int length = 32]) {
//   final charset =
//       '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
//   final random = Random.secure();
//   return List.generate(length, (_) => charset[random.nextInt(charset.length)])
//       .join();
// }
//
// /// Returns the sha256 hash of [input] in hex notation.
// String sha256ofString(String input) {
//   final bytes = utf8.encode(input);
//   final digest = sha256.convert(bytes);
//   return digest.toString();
// }
//
// RxBool applelLoader = false.obs;
// Future<UserCredential> signInWithAppleFun() async {
//   applelLoader.value = true;
//   final rawNonce = generateNonce();
//   final nonce = sha256ofString(rawNonce);
//   final appleCredential = await SignInWithApple.getAppleIDCredential(
//     scopes: [
//       AppleIDAuthorizationScopes.email,
//       AppleIDAuthorizationScopes.fullName,
//     ],
//     nonce: nonce,
//   );
//   print("hhhhhh email ----- ${appleCredential.email}");
//   print("hhhhhh f name----- ${appleCredential.familyName}");
//   print("hhhhhh given ----- ${appleCredential.givenName}");
//   print("hhhhhh  code ----- ${appleCredential.authorizationCode}");
//   // Create an `OAuthCredential` from the credential returned by Apple.
//   final oauthCredential = OAuthProvider("apple.com").credential(
//     idToken: appleCredential.identityToken,
//     rawNonce: rawNonce,
//   );
//   var _auth =
//       await FirebaseAuth.instance.signInWithCredential(oauthCredential);
//   //var email = _auth.user!.email.toString();
//   //var name = _auth.user!.photoURL.toString();
//   var uid = _auth.user!.uid;
//   // var mobileNo = _auth.user!.phoneNumber.toString();
//   // var fullname = _auth.user!.displayName.toString();
//
//   //print("hhhhhh email ----- $email $name $uid $mobileNo $fullname");
//   if (uid != "") {
//     applelLoader.value = false;
//   }
//   return _auth;
// }
//
// signInWithApple() {
//   try {
//     signInWithAppleFun();
//   } catch (e) {}
// }
}
