import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ismmart_vms/helper/global_variables.dart';

import 'package:ismmart_vms/helper/languages/translations_key.dart' as langKey;
import 'package:ismmart_vms/screens/auth/signup/signup_2/sign_up_2_view.dart';
import 'package:ismmart_vms/widgets/pick_image.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SignUpScreen1ViewModel extends GetxController {
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController cnicController = TextEditingController();
  RxString cnicFrontImage = ''.obs;
  RxString cnicBackImage = ''.obs;
  RxBool cnicFrontImageErrorVisibility = false.obs;
  RxBool cnicBackImageErrorVisibility = false.obs;
  RxMap<String, dynamic> body = <String, dynamic>{}.obs;
  RxBool obscurePassword = true.obs;
  RxBool obscureConfirmPassword = true.obs;
  Rxn phoneErrorText = Rxn<String>();
  RxString countryCode = '+92'.obs;
  RxBool changeView = false.obs;
  List genders = ['Male', 'Female', 'Other'];
  RxString selectedGender = ''.obs;

  validatorPhoneNumber(String? value) {
    if (GetUtils.isBlank(value)!) {
      phoneErrorText.value = "Field is required";
    } else if (value!.length > 16 || value.length < 7) {
      phoneErrorText.value = "Incorrect Phone number";
    } else {
      phoneErrorText.value = null;
    }
  }

  selectImage(RxString imageVar, RxBool imageVisibilityVar) async {
    final image = await PickImage().pickSingleImage();
    if (image != null) {
      imageVar.value = image.path;
      imageVisibilityVar.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    GlobalVariable.showLoader.value = false;
    super.onClose();
  }

  void signUp() {
    if (signUpFormKey.currentState?.validate() ?? false) {
      Map<String, dynamic> param = {
        "full_name": nameController.text,
        "email": emailController.text,
        "gender": selectedGender.value,
        "cnic_front_image": cnicFrontImage.value,
        "cnic_back_image": cnicBackImage.value,
        "country_code": countryCode.value,
        "phone": phoneNumberController.text,
        "password": passwordController.text,
      };

      changeView.value = true;
      body.value = param;
      print(param);
      Get.to(() => SignUp2View());
      // ApiBaseHelper()
      //     .postMethod(url: Urls.signUp, body: param)
      //     .then((parsedJson) async {
      //   GlobalVariable.showLoader.value = false;
      //
      //   if (parsedJson['message'] == 'User registered successfully.') {
      //     Get.offNamed(Routes.loginRoute);
      //     AppConstant.displaySnackBar(
      //       langKey.successTitle.tr,
      //       parsedJson['message'],
      //     );
      //     cityViewModel.cityId.value = 0;
      //     cityViewModel.countryId.value = 0;
      //     cityViewModel.authController.selectedCountry.value =
      //         CountryModel();
      //     cityViewModel.authController.selectedCity.value = CountryModel();
      //     Get.offNamed(Routes.loginRoute);
      //   } else {
      //     AppConstant.displaySnackBar(
      //       langKey.errorTitle.tr,
      //       parsedJson['message'],
      //     );
      //   }
      // }).catchError((e) {
      //   //   GlobalVariable.internetErr(true);
      //   print(e);
      //   GlobalVariable.showLoader.value = false;
      // });
    }
  }

  //Google singin
  RxString socialSignUP_Id = ''.obs;
  RxString socialSignUp_Name = ''.obs;
  RxString socialsignUp_Email = ''.obs;
  RxString socialSignUP_imgUrl = ''.obs;

  final googleSignin = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  Future googleLogIn() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );

    try {
      GoogleSignInAccount? credential = await _googleSignIn.signIn();
      print(credential);
      socialSignUP_Id.value = credential?.id ?? "";
      socialSignUp_Name.value = credential?.displayName ?? "";
      socialsignUp_Email.value = credential?.email ?? "";
      socialSignUP_imgUrl.value = credential?.photoUrl ?? "";
    } catch (error) {
      print(error);
    }
    update();
    //  var a = credential['GoogleSignInAccount']['displayName'];
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

      debugPrint("apple login====>>>  $credential");

      // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
      // after they have been validated with Apple (see `Integration` section for more information on how to do this)
    }
  }
}
