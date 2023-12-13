import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:ismmart_vms/helper/theme_helper.dart';
import 'package:ismmart_vms/screens/signup/signup_1/sign_up_1_viewmodel.dart';
import 'package:ismmart_vms/widgets/custom_button.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../helper/constants.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/image_layout_container.dart';
import '../../../widgets/obscure_suffix_icon.dart';
import '../../login/login_view.dart';
import 'package:ismmart_vms/helper/languages/translations_key.dart' as langKey;

class SignUp1View extends StatelessWidget {
  SignUp1View({super.key});
  final SignUpScreen1ViewModel viewModel = Get.put(SignUpScreen1ViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: viewModel.signUpFormKey,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        titleAndBackBtn(),
                        const Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 10),
                          child: Text(
                            'Create Account',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ),
                        progress(),
                        nameField(),
                        emailTextField(),
                        phoneNumberTextField(),
                        genderField(context),
                        cnicNumberField(),
                        cnicFrontImage(),
                        cnicBackImage(),
                        passwordTextField(),
                        confirmPasswordTextField(),
                        or(),
                        googlelogInBtn(),
                        facebooklogInBtn(),
                        applelogInBtn(),
                        signUpBtn(),
                        alreadyHaveAnAccount(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget titleAndBackBtn() {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          const Align(
            alignment: Alignment.center,
            child: Text(
              'Sign Up',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
          CustomBackButton(onTap: () {}),
        ],
      ),
    );
  }

  Widget progress() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 30),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Vendor Account Progress',
                  style: newFontStyle1.copyWith(
                    color: newColorBlue2,
                  ),
                ),
                const SizedBox(height: 6),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Next Step: ',
                        style: newFontStyle1.copyWith(
                          fontSize: 12,
                          color: newColorBlue4,
                        ),
                      ),
                      TextSpan(
                        text: 'Bank Details',
                        style: newFontStyle1.copyWith(
                          fontSize: 12,
                          color: newColorBlue3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          CircularPercentIndicator(
            circularStrokeCap: CircularStrokeCap.round,
            radius: 33,
            lineWidth: 6,
            percent: 0.05,
            backgroundColor: const Color(0xffEBEFF3),
            progressColor: const Color(0xff0CBC8B),
            center: Text(
              "1 of 3",
              style: poppinsH2.copyWith(
                color: newColorBlue2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget nameField() {
    return CustomTextField3(
      title: 'Full Name',
      hintText: 'John Doe',
      controller: viewModel.nameController,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      // validator: (value) {
      //   return Validator()
      //       .validateName(value, errorToPrompt: langKey.FirstNameReq.tr);
      // },
    );
  }

  Widget emailTextField() {
    return CustomTextField3(
      title: 'Email',
      hintText: 'asha****iq11@gmail.com',
      controller: viewModel.emailController,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      // validator: (value) {
      //   return Validator().validateEmail(value);
      // },
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget phoneNumberTextField() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: CountryCodePickerTextField2(
          // validator: (value) {
          //   return Validator().validatePhoneNumber(value);
          // },
          title: 'Phone Number',
          hintText: '336 5563138',
          keyboardType: TextInputType.number,
          controller: viewModel.phoneNumberController,
          initialValue: viewModel.countryCode.value,
          textStyle:
              const TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
          autoValidateMode: AutovalidateMode.onUserInteraction,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+?\d*')),
          ],
          errorText: viewModel.phoneErrorText.value,
          onPhoneFieldChange: (value) {
            String newPhoneValue = viewModel.countryCode.value + value;
            viewModel.validatorPhoneNumber(newPhoneValue);
          },
          onChanged: (value) {
            viewModel.countryCode.value = value.dialCode ?? '+92';
            String newPhoneValue = viewModel.countryCode.value +
                viewModel.phoneNumberController.text;
            viewModel.validatorPhoneNumber(newPhoneValue);
          },
        ),
      ),
    );
  }

  Widget genderField(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: RichText(
            text: const TextSpan(
                text: 'Gender',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
                children: [
                  TextSpan(text: ' *', style: TextStyle(color: Colors.red))
                ]),
          ),
        ),
        SizedBox(height: 30, child: genderRadioBtns(context)),
      ],
    );
  }

  Widget genderRadioBtns(BuildContext buildContext) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Center(
        child: ListView.builder(
          itemCount: viewModel.genders.length,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (buildContext, index) {
            return radioButton(index, viewModel.genders[index]);
          },
        ),
      ),
    );
  }

  Widget radioButton(int btnValue, String title) {
    return Obx(
      () => Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Radio(
            fillColor: MaterialStateColor.resolveWith((states) => Colors.black),
            activeColor: Theme.of(Get.context!).primaryColor,
            value: viewModel.genders[btnValue],
            groupValue: viewModel.selectedGender.value,
            onChanged: (value) {
              viewModel.selectedGender.value = value;
            },
          ),
          Text(
            title,
            style: const TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }

  Widget cnicNumberField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: CustomTextField3(
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          FilteringTextInputFormatter.digitsOnly,
        ],
        title: 'CNIC',
        hintText: 'Enter CNIC',
        controller: viewModel.cnicController,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        // validator: (value) {
        //   return Validator().validateCNIC(value);
        // },
      ),
    );
  }

  Widget passwordTextField() {
    return Obx(
      () => CustomTextField3(
        controller: viewModel.passwordController,
        title: 'Password',
        hintText: '● ● ● ● ● ● ● ● ● ●',
        autoValidateMode: AutovalidateMode.onUserInteraction,
        // validator: (value) {
        //   return Validator().validatePassword(value);
        // },
        obscureText: viewModel.obscurePassword.value ? true : false,
        suffixIcon: ObscureSuffixIcon(
          isObscured: viewModel.obscurePassword.value ? true : false,
          onPressed: () {
            viewModel.obscurePassword.value = !viewModel.obscurePassword.value;
          },
        ),
      ),
    );
  }

  Widget cnicFrontImage() {
    return Obx(
      () => ImageLayoutContainer(
        title: 'CNIC Front Image',
        filePath: viewModel.cnicFrontImage.value == ''
            ? ''
            : basename(viewModel.cnicFrontImage.value),
        onTap: () async {
          await viewModel.selectImage(viewModel.cnicFrontImage,
              viewModel.cnicFrontImageErrorVisibility);
        },
        errorVisibility: viewModel.cnicFrontImageErrorVisibility.value,
        errorPrompt: 'CNIC Front Image is required',
      ),
    );
  }

  Widget cnicBackImage() {
    return Obx(
      () => ImageLayoutContainer(
        title: 'CNIC Back Image',
        filePath: viewModel.cnicBackImage.value == ''
            ? ''
            : basename(viewModel.cnicBackImage.value),
        onTap: () async {
          await viewModel.selectImage(
              viewModel.cnicBackImage, viewModel.cnicBackImageErrorVisibility);
        },
        errorVisibility: viewModel.cnicBackImageErrorVisibility.value,
        errorPrompt: 'CNIC Back Image is required',
      ),
    );
  }

  Widget confirmPasswordTextField() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: CustomTextField3(
          controller: viewModel.confirmPasswordController,
          title: 'Confirm Password',
          hintText: '● ● ● ● ● ● ● ● ● ●',
          autoValidateMode: AutovalidateMode.onUserInteraction,
          // validator: (value) {
          //   return Validator().validateConfirmPassword(
          //       value, viewModel.passwordController.text);
          // },
          obscureText: viewModel.obscureConfirmPassword.value ? true : false,
          suffixIcon: ObscureSuffixIcon(
            isObscured: viewModel.obscureConfirmPassword.value ? true : false,
            onPressed: () {
              viewModel.obscureConfirmPassword.value =
                  !viewModel.obscureConfirmPassword.value;
            },
          ),
        ),
      ),
    );
  }

  Widget signUpBtn() {
    return CustomRoundedTextBtn(
      title: 'Proceed',
      onPressed: () {
        print('Sign Up Button Pressed');
        viewModel.signUp();
      },
    );
  }

  Widget alreadyHaveAnAccount() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Get.off(() => LogInView());
          },
          child: RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Already have an account?' + ' ',
                  style: TextStyle(
                    color: ThemeHelper.lightGrey,
                  ),
                ),
                TextSpan(
                  text: 'Sign In',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget or() {
    return Row(
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
            langKey.or.tr,
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
            const Text(
              "Continue in with Google",
              //style: newFontStyle3,
            ),
          ],
        ),
        onPressed: () {
          viewModel.googleLogIn();
        },
      ),

      // Obx(
      //       () => GlobalVariable.showLoader.value
      //       ? CustomLoading(isItBtn: true)
      //       :
      //
      //       CustomRoundedTextBtn(
      //     borderSide:  BorderSide(
      //       color: newColorDarkBlack, // your color here
      //       width: 1,
      //     ),
      //     backgroundColor: kWhiteColor,
      //     foregroundColor: newColorDarkBlack,
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         ClipRRect(
      //           child: Image.asset(
      //             'assets/logo/google_logo.png',
      //             width: 36,
      //             height: 36,
      //           ),
      //           borderRadius: BorderRadius.circular(50.0),
      //         ),
      //         SizedBox(
      //           width:5,
      //         ),
      //         Text(
      //           "Continue in with Google",
      //           style: newFontStyle3,
      //         ),
      //       ],),
      //     onPressed: () {
      //       viewModel.signInWithApple();
      //     },
      //   ),
      //
      // ),
      //
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
            const Text(
              "Continue with Apple ID",
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

      // Obx(
      //       () => GlobalVariable.showLoader.value
      //       ? CustomLoading(isItBtn: true)
      //       :
      //       CustomRoundedTextBtn(
      //     borderSide:  BorderSide(
      //       color: newColorDarkBlack, // your color here
      //       width: 1,
      //     ),
      //     backgroundColor: kWhiteColor,
      //     foregroundColor: newColorDarkBlack,
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         ClipRRect(
      //           child: Image.asset(
      //             'assets/logo/fb_logo.png',
      //             width: 36,
      //             height: 36,
      //           ),
      //           borderRadius: BorderRadius.circular(50.0),
      //         ),
      //         SizedBox(
      //           width:5,
      //         ),
      //         Text(
      //           "Continue in with Facebok",
      //           style: newFontStyle3,
      //         ),
      //       ],),
      //     onPressed: () {
      //       viewModel.signInWithApple();
      //     },
      //   ),
      //
      // ),
    );
  }
}
