import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/global_variables.dart';
import 'package:ismmart_vms/helper/languages/translations_key.dart';
import 'package:ismmart_vms/helper/routes.dart';
import 'package:ismmart_vms/helper/utils/size_utils.dart';
import 'package:ismmart_vms/helper/validator.dart';
import 'package:ismmart_vms/widgets/custom_button.dart';
import 'package:ismmart_vms/widgets/custom_loading.dart';
import 'package:ismmart_vms/widgets/custom_text.dart';
import 'package:ismmart_vms/widgets/custom_textfield.dart';
import 'package:ismmart_vms/widgets/obscure_suffix_icon.dart';
import 'package:ismmart_vms/widgets/scrollable_column.dart';

import '../../../helper/constants.dart';
import '../signup/signup_1/sign_up_1_view.dart';
import '../signup/signup_methods/singup_methods_view.dart';
import 'login_viewmodel.dart';

class LogInView extends StatelessWidget {
  LogInView({super.key});
  final LogInViewModel viewModel = Get.put(LogInViewModel());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 25),
          child: Stack(
            children: [
              Form(
                key: viewModel.signInFormKey,
                child: ScrollableColumn(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.h),
                    titleAndBackBtn(),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 52, bottom: 10),
                      child: CustomText(
                        title: 'Welcome Back!',
                        style: newFontStyleSize20,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            right: 20, bottom: 32, top: 16),
                        child: Text(
                            maxLines: 2,
                            'Please login or sign up to continue our app',
                            style: newFontStyleSize14)),
                    emailTextField(),
                    passwordTextField(),
                    forgotPassword(),
                    logInBtn(),

                    orWidget(),
                    googlelogInBtn(),
                    // facebooklogInBtn(),
                    applelogInBtn(),
                    doNotHaveAnAccount(),
                  ],
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
      padding: const EdgeInsets.only(left: 58, right: 57),
      width: double.infinity,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              "Login",
              style: newFontStyleSize24,
            ),
          ),
          // CustomBackButton(
          //   onTap: () {
          //     Get.back();
          //   },
          // ),
        ],
      ),
    );
  }

  Widget emailTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: CustomTextField1(
        prefixIcon: Icons.person,
        title: 'Email / Phone Number',
        hintText: 'Email / Phone Number',
        controller: viewModel.emailController,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return Validator.validateEmail(value);
        },
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }

  Widget passwordTextField() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 16),
        child: CustomTextField1(
          prefixIcon: Icons.lock,
          controller: viewModel.passwordController,
          title: "Password",
          hintText: '***********',
          autoValidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            return Validator().validateDefaultTxtField(value,
                errorPrompt: "Password is Required");
          },
          obscureText: viewModel.obscurePassword.value ? true : false,
          suffixIconButton: ObscureSuffixIcon(
            isObscured: viewModel.obscurePassword.value ? true : false,
            onPressed: () {
              viewModel.obscurePassword.value =
                  !viewModel.obscurePassword.value;
            },
          ),
        ),
      ),
    );
  }

//Google Button
  Widget googlelogInBtn() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: CustomRoundedTextBtn(
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
                width: 36,
                height: 36,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              'Sign in with Gmail',
              style: newFontStyleSize14.copyWith(fontWeight: FontWeight.w500),
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
      child: CustomRoundedTextBtn(
        borderSide: const BorderSide(
          color: Colors.black, // your color here
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
                'assets/logo/apple_logo.png',
                width: 36,
                height: 36,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              "Signin with Apple ID",
              style: newFontStyleSize14.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        onPressed: () {
          viewModel.appleSignin();
        },
      ),
    );
  }

  //Facebook Button
  Widget facebooklogInBtn() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: CustomRoundedTextBtn(
        borderSide: const BorderSide(
          color: Colors.black, // your color here
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
                'assets/logo/fb_logo.png',
                width: 36,
                height: 36,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            const Text(
              "Continue in with Facebok",
              // style: newFontStyle3,
            ),
          ],
        ),
        onPressed: () {
          // viewModel.signInWithApple();
        },
      ),
    );
  }

  Widget logInBtn() {
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
                      "Login",
                      style: newFontStyleSize14.copyWith(
                          fontWeight: FontWeight.w500, color: kWhiteColor),
                    ),
                    SizedBox(width: 4.h),
                    const Icon(
                      Icons.arrow_forward,
                      size: 20,
                    ),
                  ],
                ),
                onPressed: () {
                  viewModel.signIn();
                  // Get.offNamed(Routes.dashboard);
                  //
                },
              ),
      ),
    );
  }

  Widget signUpBtn() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 25),
      child: Obx(
        () => GlobalVariable.showLoader.value
            ? const CustomLoading(isItBtn: true)
            : CustomRoundedTextBtn(
                backgroundColor: Colors.black,
                child: const Text(
                  "Signup",
                ),
                onPressed: () {
                  Get.off(SignUp1View());
                },
              ),
      ),
    );
  }

  Widget forgotPassword() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20, right: 10, top: 2),
      alignment: Alignment.centerRight,
      child: InkWell(
          onTap: () {
            Get.toNamed(Routes.forgotPassword1, arguments: {
              'email': GetUtils.isEmail(viewModel.emailController.text)
                  ? viewModel.emailController.text
                  : ''
            });
          },
          child: CustomText(
            title: 'Forget Password?',
            style: newFontStyleSize14.copyWith(fontWeight: FontWeight.w500),
          )),
    );
  }

  Widget orWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
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
            child: Text(or.tr
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

  Widget doNotHaveAnAccount() {
    return TextButton(
      onPressed: () {
        Get.to(() => SingupMethodsView());
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 133),
        child: Center(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: "Don't have an account?",
                    style:
                        newFontStyleSize14.copyWith(color: newColorLightGrey2)),
                TextSpan(
                    text: " Create Account",
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
