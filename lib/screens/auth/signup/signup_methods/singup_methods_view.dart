import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/utils/size_utils.dart';
import 'package:ismmart_vms/screens/auth/login/login_view.dart';
import 'package:ismmart_vms/screens/auth/signup/signup_1/sign_up_1_view.dart';
import 'package:ismmart_vms/screens/auth/signup/signup_methods/signup_mehods_viewmodel.dart';
import 'package:ismmart_vms/widgets/custom_button.dart';
import 'package:ismmart_vms/widgets/custom_text.dart';
import 'package:ismmart_vms/widgets/loader_view.dart';
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
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Stack(
            children: [
              ScrollableColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  titleAndBackBtn(),
                  const Divider(
                    color: Color(0xffEEEEEE),
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 52, bottom: 10),
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
                  if (Platform.isIOS) applelogInBtn(),
                  const Spacer(),
                  doNotHaveAnAccount(),
                ],
              ),
              const LoaderView(),
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
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0, left: 10),
            child: CustomBackButton(onTap: () {
              Get.back();
            }),
          ),
          const SizedBox(width: 100),
          Text(
            'Sign Up',
            style: newFontStyleSize24,
          ),
        ],
      ),
    );
  }

  Widget signUpEmail() {
    return Padding(
        padding: const EdgeInsets.only(top: 32),
        child: CustomTextBtn(
          radius: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Continue with email',
                // style: newFontStyleSize14.copyWith(
                //     fontWeight: FontWeight.w500, color: kWhiteColor),kWhiteColor
              ),
              SizedBox(width: 4.h),
              const Icon(
                Icons.arrow_forward,
                size: 20,
              ),
            ],
          ),
          onPressed: () {
            Get.to(SignUp1View());
            // Get.offNamed(Routes.dashboard);
            //
          },
        ));
  }

  Widget signupNumber() {
    return Padding(
        padding: const EdgeInsets.only(top: 22),
        child: CustomTextBtn(
          // padding: const EdgeInsets.only(top: 5),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          radius: 30,
          borderSide: const BorderSide(
            color: Colors.black, // your color here
            width: 1,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Continue with phone number',

                // style: newFontStyleSize14.copyWith(
                //     color: newColorDarkBlack, fontWeight: FontWeight.w600),
              ),
              SizedBox(width: 4.h),
              Icon(
                Icons.arrow_forward,
                size: 20,
                color: newColorDarkBlack,
              ),
            ],
          ),
          onPressed: () {
            Get.to(SignUp1View());
            // Get.offNamed(Routes.dashboard);
            //
          },
        ));

    // Padding(
    //   padding: const EdgeInsets.only(top: 10),
    //   child: Obx(
    //     () => GlobalVariable.showLoader.value
    //         ? const CustomLoading(isItBtn: true)
    //         : CustomRoundedTextBtn(
    //             borderSide: const BorderSide(
    //               color: Colors.black, // your color here
    //               width: 1,
    //             ),
    //             backgroundColor: Colors.white,
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 Text(
    //                   'Continue with phone number',
    //                   style: newFontStyleSize14.copyWith(
    //                       fontWeight: FontWeight.w500,
    //                       color: newColorDarkBlack),
    //                 ),
    //                 const SizedBox(
    //                   width: 4,
    //                 ),
    //                 const Icon(
    //                   Icons.arrow_forward,
    //                   size: 20,
    //                   color: newColorDarkBlack,
    //                 ),
    //               ],
    //             ),
    //             onPressed: () {
    //               // Get.offNamed(Routes.dashboard);
    //               // Get.to(DashboardView());
    //             },
    //           ),
    //   ),
    // );
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
    return CustomTextBtn(
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
          const Text(
            'Sign in with Gmail',
            // style: newFontStyleSize14.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
      onPressed: () {
        viewModel.googleLogIn();
      },
    );
  }

  Widget applelogInBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
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
            const Text(
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
