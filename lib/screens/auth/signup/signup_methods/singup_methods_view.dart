import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/global_variables.dart';
import 'package:ismmart_vms/helper/utils/size_utils.dart';
import 'package:ismmart_vms/screens/auth/login/login_view.dart';
import 'package:ismmart_vms/screens/auth/signup/signup_1/sign_up_1_view.dart';
import 'package:ismmart_vms/screens/auth/signup/signup_methods/signup_mehods_viewmodel.dart';
import 'package:ismmart_vms/widgets/custom_button.dart';
import 'package:ismmart_vms/widgets/custom_loading.dart';
import 'package:ismmart_vms/widgets/custom_text.dart';
import 'package:ismmart_vms/widgets/scrollable_column.dart';
import 'package:ismmart_vms/helper/languages/translations_key.dart';

import '../../../../helper/constants.dart';

class SingupMethodsView extends StatelessWidget {
  SingupMethodsView({super.key});
  final SignupMehtodsViewModel viewModel = Get.put(SignupMehtodsViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 25),
          child: Stack(
            children: [
              ScrollableColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 200, bottom: 10),
                    child: CustomText(
                      title: 'Get onboard!',
                      style: newFontStyleSize20,
                    ),
                  ),
                  Padding(
                      padding:
                          const EdgeInsets.only(right: 20, bottom: 32, top: 16),
                      child: Text('Create your account',
                          style: newFontStyleSize14)),
                  signUpEmail(),
                  signupNumber(),

                  orWidget(),
                  googlelogInBtn(),
                  // facebooklogInBtn(),
                  applelogInBtn(),
                  const Spacer(),
                  doNotHaveAnAccount(),
                ],
              ),
              Positioned(
                  left: 50,
                  top: 5,
                  child: SizedBox(
                      width: 300, height: 100, child: titleAndBackBtn())),
              Positioned(
                top: 20,
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: CustomBackButton(
                    onTap: () {
                      Get.back();
                    },
                  ),
                ),
              ),
              // NoInternetView(
              //   onPressed: () => viewModel.signIn(),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleAndBackBtn() {
    return Container(
      padding: const EdgeInsets.only(left: 58, right: 57, top: 26, bottom: 52),
      width: double.infinity,
      child: Align(
        alignment: Alignment.center,
        child: Text(
          "Sign Up",
          style: newFontStyleSize24,
        ),
      ),
    );
  }

  Widget signUpEmail() {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Obx(
        () => GlobalVariable.showLoader.value
            ? const CustomLoading(isItBtn: true)
            : CustomRoundedTextBtn(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Continue with email',
                      style: newFontStyleSize14.copyWith(
                          fontWeight: FontWeight.w500, color: kWhiteColor),
                    ),
                    SizedBox(width: 4.v),
                    const Icon(
                      Icons.arrow_forward,
                      size: 20,
                    ),
                  ],
                ),
                onPressed: () {
                  Get.to(SignUp1View());
                },
              ),
      ),
    );
  }

  Widget signupNumber() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Obx(
        () => GlobalVariable.showLoader.value
            ? const CustomLoading(isItBtn: true)
            : CustomRoundedTextBtn(
                borderSide: const BorderSide(
                  color: Colors.black, // your color here
                  width: 1,
                ),
                backgroundColor: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Continue with phone number',
                      style: newFontStyleSize14.copyWith(
                          fontWeight: FontWeight.w500,
                          color: newColorDarkBlack),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const Icon(
                      Icons.arrow_forward,
                      size: 20,
                      color: newColorDarkBlack,
                    ),
                  ],
                ),
                onPressed: () {
                  // Get.offNamed(Routes.dashboard);
                  // Get.to(DashboardView());
                },
              ),
      ),
    );
  }

  Widget orWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 24),
      child: Row(
        children: [
          const Expanded(
            child: Divider(
              //color: newColorLightGrey,
              thickness: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              or.tr,
              //style: newFontStyle4,
            ),
          ),
          const Expanded(
            child: Divider(
              //color: newColorLightGrey,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }

//Google Button
  Widget googlelogInBtn() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: CustomTextBtn(
        radius: 30,
        borderSide: const BorderSide(
          //color: newColorDarkBlack, // your color here
          width: 1,
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.asset(
                'assets/logo/google_logo.png',
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              'Sign in with Gmail',
              // style: newFontStyleSize14.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        onPressed: () {
          viewModel.googleLogIn();
        },
      ),
    );
  }

  Widget applelogInBtn() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 25),
      child: CustomTextBtn(
        radius: 30,
        borderSide: const BorderSide(
          color: Colors.black, // your color here
          width: 1,
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo/apple_logo.png',
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              "Signin with Apple ID",
            ),
          ],
        ),
        onPressed: () {
          viewModel.appleSignin();
        },
      ),
    );
  }

  Widget doNotHaveAnAccount() {
    return Padding(
      padding: const EdgeInsets.only(top: 133),
      child: Center(
        child: TextButton(
          onPressed: () {
            Get.to(() => LogInView());
          },
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: 'Already have an account?',
                    style:
                        newFontStyleSize14.copyWith(color: newColorLightGrey2)),
                TextSpan(
                    text: " Login",
                    style: newFontStyleSize14.copyWith(
                        fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
