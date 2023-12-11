import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/theme_helper.dart';
import 'package:ismmart_vms/screens/signup/signup_viewmodel.dart';
import 'package:ismmart_vms/widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/obscure_suffix_icon.dart';
import '../login/login_view.dart';

class SignUpView extends StatelessWidget {
  SignUpView({Key? key}) : super(key: key);
  final SignUpViewModel viewModel = Get.put(SignUpViewModel());

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
                        // titleAndBackBtn(),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 10),
                          child: Text(
                            'Create Account',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black
                              ),
                        ),
                          ),
                 // Padding(
                 //          padding: const EdgeInsets.only(bottom: 25),
                 //          child: Text(
                 //            langKey.getOnboardUser.tr,
                 //            style: newFontStyle0.copyWith(
                 //              color: newColorLightGrey2,
                 //            ),
                 //          ),
                 //        ),
                        firstNameField(),
                        // lastNameField(),
                        emailTextField(),
                        phoneNumberTextField(),
                        passwordTextField(),
                        confirmPasswordTextField(),
                        // countryPicker(),
                        // cityPicker(),
                        // checkBoxTermCondition(),
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
    return Container(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              'Sign Up',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
          CustomTextBtn(
            onPressed: (){},
            backgroundColor: Colors.black,
            child: Text(
              'Press',
              style: TextStyle(
                color: Colors.white
              ),
            ),

          )
          // CustomTxtBtn(
          //   onTap: () {
          //     Get.back();
          //   },
          // ),
        ],
      ),
    );
  }

  Widget firstNameField() {
    return CustomTextField1(
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
        padding: const EdgeInsets.only(top: 20, bottom: 30),
        child: CountryCodePickerTextField2(
          // validator: (value) {
          //   return Validator().validatePhoneNumber(value);
          // },
          title: 'Phone Number',
          hintText: '336 5563138',
          keyboardType: TextInputType.number,
          controller: viewModel.phoneNumberController,
          initialValue: viewModel.countryCode.value,
          textStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
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

  Widget ownerCNICField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: CustomTextField3(
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          FilteringTextInputFormatter.digitsOnly,
        ],
        title: "CNIC",
        hintText: 'Enter CNIC',
        controller: viewModel.cnicController,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        // validator: (value) {
        //   return Validator().validateCNIC(value);
        // },
      ),
    );
  }

  // Widget countryPicker() {
  //   return Obx(
  //     () => Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.only(bottom: 3),
  //           child: RichText(
  //             text: TextSpan(
  //               text: langKey.country.tr,
  //               style: GoogleFonts.dmSans(
  //                 fontSize: 14,
  //                 fontWeight: FontWeight.w700,
  //                 color: newColorDarkBlack2,
  //               ),
  //               children: [
  //                 TextSpan(
  //                   text: ' *',
  //                   style: TextStyle(color: Colors.red),
  //                 )
  //               ],
  //             ),
  //           ),
  //         ),
  //         DropdownSearch<CountryModel>(
  //           popupProps: PopupProps.dialog(
  //             showSearchBox: true,
  //             dialogProps: DialogProps(
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(10),
  //               ),
  //             ),
  //             searchFieldProps: AppConstant.searchFieldProp(),
  //           ),
  //           items: cityViewModel.authController.countries,
  //           itemAsString: (model) => model.name ?? "",
  //           dropdownDecoratorProps: DropDownDecoratorProps(
  //             baseStyle: newFontStyle0.copyWith(
  //               color: newColorDarkBlack2,
  //               fontSize: 15,
  //             ),
  //             dropdownSearchDecoration: InputDecoration(
  //               contentPadding: EdgeInsets.only(top: 13.5),
  //               suffixIconColor: Color(0xffADBCCB),
  //               isDense: true,
  //               hintText: langKey.chooseCountry.tr,
  //               hintStyle: TextStyle(color: Colors.black),
  //               enabledBorder: UnderlineInputBorder(
  //                 borderSide: BorderSide(color: Color(0xffEEEEEE)),
  //               ),
  //               focusedBorder: UnderlineInputBorder(
  //                 borderSide: BorderSide(color: Color(0xff929AAB)),
  //               ),
  //             ),
  //           ),
  //           onChanged: (CountryModel? newValue) {
  //             cityViewModel.setSelectedCountry(newValue!);
  //             viewModel.countryID.value = newValue.id!;
  //             cityViewModel.selectedCity.value = CountryModel();
  //             cityViewModel.cityId.value = 0;
  //             cityViewModel.authController.selectedCity.value = CountryModel();
  //             viewModel.countryErrorVisibility.value = false;
  //           },
  //           selectedItem: authController.newAcc.value == true
  //               ? cityViewModel.selectedCountry.value
  //               : cityViewModel.authController.selectedCountry.value,
  //         ),
  //         Obx(
  //           () => Visibility(
  //             visible: viewModel.countryErrorVisibility.value,
  //             child: Text(
  //               langKey.countryReq.tr,
  //               style: GoogleFonts.dmSans(
  //                 color: Colors.red.shade700,
  //               ),
  //             ),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  // Widget cityPicker() {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(vertical: 20),
  //     child: Obx(
  //       () => authController.cities.isEmpty
  //           ? Container()
  //           : authController.isLoading.isTrue
  //               ? CustomLoading(
  //                   isItForWidget: true,
  //                   color: kPrimaryColor,
  //                 )
  //               : Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Padding(
  //                       padding: const EdgeInsets.only(bottom: 3),
  //                       child: RichText(
  //                         text: TextSpan(
  //                           text: langKey.city.tr,
  //                           style: GoogleFonts.dmSans(
  //                             fontSize: 14,
  //                             fontWeight: FontWeight.w700,
  //                             color: newColorDarkBlack2,
  //                           ),
  //                           children: [
  //                             TextSpan(
  //                               text: ' *',
  //                               style: TextStyle(color: Colors.red),
  //                             )
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                     DropdownSearch<CountryModel>(
  //                       popupProps: PopupProps.dialog(
  //                         showSearchBox: true,
  //                         dialogProps: DialogProps(
  //                           shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(10),
  //                           ),
  //                         ),
  //                         searchFieldProps: AppConstant.searchFieldProp(),
  //                       ),
  //                       items: cityViewModel.authController.cities,
  //                       itemAsString: (model) => model.name ?? "",
  //                       dropdownDecoratorProps: DropDownDecoratorProps(
  //                         baseStyle: newFontStyle0.copyWith(
  //                           color: newColorDarkBlack2,
  //                           fontSize: 15,
  //                         ),
  //                         dropdownSearchDecoration: InputDecoration(
  //                           contentPadding: EdgeInsets.only(top: 13.5),
  //                           suffixIconColor: Color(0xffADBCCB),
  //                           isDense: true,
  //                           hintText: langKey.chooseCountry.tr,
  //                           enabledBorder: UnderlineInputBorder(
  //                             borderSide: BorderSide(color: Color(0xffEEEEEE)),
  //                           ),
  //                           focusedBorder: UnderlineInputBorder(
  //                             borderSide: BorderSide(color: Color(0xff929AAB)),
  //                           ),
  //                         ),
  //                       ),
  //                       onChanged: (CountryModel? newValue) {
  //                         cityViewModel.selectedcity.value =
  //                             newValue!.name ?? "";
  //                         cityViewModel.setSelectedCity(newValue);
  //                         viewModel.cityID.value = newValue.id!;
  //                         viewModel.cityErrorVisibility.value = false;
  //                       },
  //                       selectedItem: authController.newAcc.value == true
  //                           ? cityViewModel.selectedCity.value
  //                           : cityViewModel.authController.selectedCity.value,
  //                     ),
  //                     Obx(
  //                       () => Visibility(
  //                         visible: viewModel.cityErrorVisibility.value,
  //                         child: Text(
  //                           langKey.cityReq.tr,
  //                           style: GoogleFonts.dmSans(
  //                             color: Colors.red.shade700,
  //                           ),
  //                         ),
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //     ),
  //   );
  // }

  // Widget checkBoxTermCondition() {
  //   return Obx(
  //     () => Padding(
  //       padding: const EdgeInsets.only(bottom: 25, top: 5),
  //       child: CustomCheckBox2(
  //         value: viewModel.termAndCondition.value,
  //         onChanged: (value) {
  //           viewModel.termAndCondition.value = value;
  //         },
  //         text: Padding(
  //           padding: const EdgeInsets.only(top: 6),
  //           child: RichText(
  //             text: TextSpan(
  //               style: newFontStyle0.copyWith(
  //                 color: newColorLightGrey2,
  //               ),
  //               children: [
  //                 TextSpan(
  //                   text:
  //                       'By clicking ‘Create Account’, you’ve read and agreed to our ',
  //                 ),
  //                 TextSpan(
  //                     text: 'Terms & Conditions',
  //                     style: newFontStyle0.copyWith(
  //                       decoration: TextDecoration.underline,
  //                       color: newColorLightGrey2,
  //                     ),
  //                     recognizer: TapGestureRecognizer()
  //                       ..onTap = () {
  //                         Get.toNamed(Routes.staticInfo, arguments: {
  //                           'title': langKey.termsAndConditions.tr
  //                         });
  //                       }),
  //                 TextSpan(
  //                   text:
  //                       ' and for my personal data to be processed according to',
  //                 ),
  //                 TextSpan(
  //                   text: ' ISMMART ',
  //                   style: newFontStyle0.copyWith(
  //                     color: newColorBlue2,
  //                     fontWeight: FontWeight.w700,
  //                   ),
  //                 ),
  //                 TextSpan(text: 'Privacy Policy.'),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

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
            text: TextSpan(
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
}