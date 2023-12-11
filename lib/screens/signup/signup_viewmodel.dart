import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../helper/global_variables.dart';

class SignUpViewModel extends GetxController {
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController cnicController = TextEditingController();
  // RxInt countryID = 0.obs;
  // RxInt cityID = 0.obs;
  // RxBool countryErrorVisibility = false.obs;
  // RxBool cityErrorVisibility = false.obs;
  RxBool obscurePassword = true.obs;
  RxBool obscureConfirmPassword = true.obs;
  Rxn phoneErrorText = Rxn<String>();
  RxString countryCode = '+92'.obs;
  RxBool changeView = false.obs;
  // RxBool termAndCondition = false.obs;

  validatorPhoneNumber(String? value) {
    if (GetUtils.isBlank(value)!) {
      phoneErrorText.value = "Field is required";
    } else if (value!.length > 16 || value.length < 7) {
      phoneErrorText.value = "Incorrect Phone number";
    } else {
      phoneErrorText.value = null;
    }
  }

  // @override
  // void onInit() async {
  //   await authController.getCountries();
  //   super.onInit();
  // }

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
    // GlobalVariable.internetErr(false);
    if (signUpFormKey.currentState?.validate() ?? false) {

          Map<String, dynamic> param = {
            "full_name": nameController.text,
            "email": emailController.text,
            "country_code": countryCode.value,
            "phone": phoneNumberController.text,
            "password": passwordController.text,
          };

          changeView.value = true;
          print(param);
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
}
