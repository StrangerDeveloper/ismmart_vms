import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:ismmart_vms/helper/languages/translations_key.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'package:ismmart_vms/helper/global_variables.dart';
import 'package:ismmart_vms/helper/urls.dart';
import 'package:ismmart_vms/screens/auth/signup/signup_2/sign_up_2_view.dart';
import 'package:ismmart_vms/widgets/pick_image.dart';

import '../../../../helper/api_base_helper.dart';
import '../../../../helper/constants.dart';
import '../signup_methods/signup_mehods_viewmodel.dart';

class SignUpScreen1ViewModel extends GetxController {
  GlobalKey<FormState> signUpFormKey1 = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController cnicController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
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

  final SignupMehtodsViewModel _socialviewModel =
      Get.put(SignupMehtodsViewModel());
  String socialToken = '';
  @override
  void onReady() {
    nameController.text = _socialviewModel.socialName.value;
    emailController.text = _socialviewModel.socialEmail.value;
    emailController.text = _socialviewModel.socialEmail.value;
    socialToken = _socialviewModel.socialToken.value;

    print("${socialToken}  ${emailController.text}");
    // TODO: implement onReady
    super.onReady();
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

  List<http.MultipartFile> fileList = [];
  void signUpStep1() async {
    if (signUpFormKey1.currentState?.validate() ?? false) {
      fileList.clear();

      //------    Image Varification and Send To Api ------------
      if (cnicFrontImage.value.isNotEmpty && cnicBackImage.value.isNotEmpty) {
        fileList.add(
          await http.MultipartFile.fromPath(
            'cnicImages',
            cnicFrontImage.value,
            contentType: MediaType.parse('image/jpeg'),
          ),
        );
        fileList.add(
          await http.MultipartFile.fromPath(
            'cnicImages',
            cnicBackImage.value,
            contentType: MediaType.parse('image/jpeg'),
          ),
        );
      } else {
        AppConstant.displaySnackBar(
          " Error",
          " please upload CNIC Images",
        );
      }

      //------- Social Signup Checks ----------
      Map<String, String> param = {};
      if (_socialviewModel.socialPlatform.value != "" &&
          _socialviewModel.socialToken.value != "") {
        param = {
          "name": nameController.text,
          "email": emailController.text,
          "gender": selectedGender.value,
          "cnic": cnicController.text,
          "phone": countryCode.value + phoneNumberController.text,
          "password": passwordController.text,
          "confirmPassword": confirmPasswordController.text,
          "Socila":
              "{ social[name]: ${_socialviewModel.socialPlatform.value}, 'social[token]': ${_socialviewModel.socialToken.value}   }",
          'step': '1'
        };
      } else {
        param = {
          "name": nameController.text,
          "email": emailController.text,
          "gender": selectedGender.value,
          "cnic": cnicController.text,
          "phone": countryCode.value + phoneNumberController.text,
          "password": passwordController.text,
          "confirmPassword": confirmPasswordController.text,
          'step': '1'
        };
      }

      changeView.value = true;
      body.value = param;
      GlobalVariable.showLoader.value = true;
      await ApiBaseHelper()
          .postMethodForImage(
              url: Urls.register, files: fileList, fields: param)
          .then((parsedJson) {
        print(cnicFrontImage.value);
        if (parsedJson['success'] == true) {
          print("success====== Step 1");
          GlobalVariable.showLoader(false);
          param.removeWhere((key, value) => value == "1");
          Get.to(() => SignUp2View(), arguments: param);
        } else {
          GlobalVariable.showLoader(false);
          AppConstant.displaySnackBar(
            "Error",
            parsedJson['message'],
          );
        }
      });
    } else {
      GlobalVariable.showLoader(false);
    }
  }

  //Google singin
  RxString socialSignUpId = ''.obs;
  RxString socialSignUpName = ''.obs;
  RxString socialsignUpEmail = ''.obs;
  RxString socialSignUPimgUrl = ''.obs;

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

    try {
      GoogleSignInAccount? credential = await googleSignIn.signIn();
      //print(credential);
      socialSignUpId.value = credential?.id ?? "";
      socialSignUpName.value = credential?.displayName ?? "";
      socialsignUpEmail.value = credential?.email ?? "";
      socialSignUPimgUrl.value = credential?.photoUrl ?? "";
    } catch (error) {
      debugPrint("$error");
    }
    //update();
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
