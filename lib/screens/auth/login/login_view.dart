import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/common_function.dart';
import 'package:ismmart_vms/helper/languages/translations_key.dart';
import 'package:ismmart_vms/helper/routes.dart';
import 'package:ismmart_vms/helper/utils/size_utils.dart';
import 'package:ismmart_vms/helper/validator.dart';
import 'package:ismmart_vms/widgets/custom_button.dart';
import 'package:ismmart_vms/widgets/custom_text.dart';
import 'package:ismmart_vms/widgets/custom_textfield.dart';
import 'package:ismmart_vms/widgets/loader_view.dart';
import 'package:ismmart_vms/widgets/obscure_suffix_icon.dart';
import '../../../helper/constants.dart';
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
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 26, horizontal: 25),
                child: Form(
                  key: viewModel.signInFormKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 52.h),
                        titleAndBackBtn(),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 72,
                          ),
                          child: CustomText(
                            title: 'Welcome Back!',
                            style: newFontStyleSize20,
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                right: 20, bottom: 15, top: 16),
                            child: Text(
                                maxLines: 2,
                                'Please login or sign up to continue our app',
                                style: newFontStyleSize14.copyWith(
                                    color: newColorLightGrey2))),
                        emailTextField(),
                        passwordTextField(),
                        forgotPassword(),
                        logInBtn(),

                        orWidget(),
                        googlelogInBtn(),
                        // facebooklogInBtn(),
                        // if (Platform.isIOS) applelogInBtn(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .07,
                        ),
                        doNotHaveAnAccount(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const LoaderView()
          ],
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
        title: 'Email ',
        hintText: 'Email ',
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
        padding: const EdgeInsets.only(
          top: 16,
        ),
        child: CustomTextField1(
          prefixIcon: Icons.lock,
          controller: viewModel.passwordController,
          title: "Password",
          hintText: '***********',
          autoValidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            return Validator.validatePassword(value);
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
    return CustomTextBtn(
      radius: 30,
      borderSide: const BorderSide(
        color: newColorLightGrey, // your color here
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
            width: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text('Sign in with Gmail',
                style:
                    newFontStyleSize14.copyWith(fontWeight: FontWeight.w500)),
          ),
        ],
      ),
      onPressed: () {
        viewModel.googleLogIn();
      },
    );
  }

  Widget applelogInBtn() {
    return CustomTextBtn(
      radius: 30,
      borderSide: const BorderSide(
        color: newColorLightGrey, // your color here
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
        child: CustomTextBtn(
          radius: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login",
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
            viewModel.signIn();
            //
          },
        ));
  }

  Widget forgotPassword() {
    return Container(
        margin: const EdgeInsets.only(
          bottom: 20,
          right: 10,
        ),
        alignment: Alignment.centerRight,
        child: TextButton(
            onPressed: () {
              CommonFunction.debugPrint(
                  "forget --------${viewModel.emailController.text}");
              Get.toNamed(Routes.forgotPassword1, arguments: {
                'email': GetUtils.isEmail(viewModel.emailController.text)
                    ? viewModel.emailController.text
                    : ''
              });
            },
            child: CustomText(
              title: 'Forget Password?',
              style: newFontStyleSize14.copyWith(fontWeight: FontWeight.w600),
            )));
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
    return Align(
      alignment: Alignment.bottomCenter,
      child: TextButton(
        onPressed: () {
          Get.to(() => SingupMethodsView());
        },
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
                        fontWeight: FontWeight.w800)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
