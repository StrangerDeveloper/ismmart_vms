import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/widgets/image_layout_container.dart';
import 'package:path/path.dart';
import 'package:ismmart_vms/widgets/custom_textfield.dart';
import 'package:ismmart_vms/widgets/obscure_suffix_icon.dart';
import 'package:ismmart_vms/widgets/custom_button.dart';

import 'edit_user_profile_viewmodel.dart';

class EditUserProfileView extends StatelessWidget {
  EditUserProfileView({super.key});
  final EditUserProfileViewModel viewModel = Get.put(EditUserProfileViewModel());

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
                        const SizedBox(height: 40),
                        nameField(),
                        const SizedBox(height: 20),
                        emailTextField(),
                        phoneNumberTextField(),
                        genderField(context),
                        const SizedBox(height: 40),
                        passwordTextField(),
                        confirmPasswordTextField(),
                        cnicNumberField(),
                        cnicFrontImage(),
                        cnicBackImage(),
                        signUpBtn(),
                        discardbtn(),
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
              'Edit Profile',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
          CustomBackButton(onTap: () {
            Get.back();
          }),
        ],
      ),
    );
  }

  Widget nameField() {
    return CustomTextField3(
      title: 'Name',
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
            return radioButton(index, viewModel.genders[index] as String);
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
              viewModel.selectedGender.value = value as String;
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
        title: 'CNIC Number',
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
      title: 'Save & Update',
      onPressed: () {},
    );
  }

  Widget discardbtn() {
    return CustomRoundedTextBtn(
      title: 'Discard',
      onPressed: () {},
      backgroundColor: Color.fromARGB(255, 85, 77, 77),
    );
  }
}
