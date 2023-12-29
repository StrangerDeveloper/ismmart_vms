import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/widgets/custom_appbar.dart';
import 'package:ismmart_vms/widgets/custom_button.dart';
import 'package:ismmart_vms/widgets/custom_textfield.dart';
import 'package:ismmart_vms/widgets/image_layout_container.dart';
import 'package:ismmart_vms/widgets/loader_view.dart';
import 'package:ismmart_vms/widgets/obscure_suffix_icon.dart';
import 'package:path/path.dart';

import '../../helper/theme_helper.dart';
import '../../helper/validator.dart';
import 'edit_user_profile_viewmodel.dart';

class EditUserProfileView extends StatelessWidget {
  EditUserProfileView({super.key});

  final EditUserProfileViewModel viewModel =
      Get.put(EditUserProfileViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar2(
        title: 'Edit Profile',
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: viewModel.userProfileFormKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        profileImage(),
                        nameField(),
                        emailTextField(),
                        phoneNumberTextField(),
                        genderTextField(),
                        passwordTextField(),
                        confirmPasswordTextField(),
                        cNICNumberField(),
                        cnicFrontImage(),
                        cnicBackImage(),
                        signUpBtn(),
                        discardBtn(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const LoaderView(),
        ],
      ),
    );
  }

  Widget profileImage() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 25),
      child: Align(
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Obx(
                () => (viewModel.pickedFile.value.path != "")
                    ? Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: FileImage(viewModel.pickedFile.value),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : CachedNetworkImage(
                        height: 80,
                        width: 80,
                        imageUrl: '',
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                        errorWidget: (context, url, error) {
                          return Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage('assets/logo/logo_new.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                        placeholder: (context, url) {
                          return const Center(
                            child: CircularProgressIndicator(strokeWidth: 2.0),
                          );
                        },
                      ),
              ),
            ),
            Positioned(
              right: 8,
              bottom: 4,
              child: InkWell(
                onTap: () {
                  // showPicker(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(3.5),
                  decoration: BoxDecoration(
                    color: ThemeHelper.blue1,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.8),
                  ),
                  child: const Icon(
                    Icons.edit_outlined,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget nameField() {
    return CustomTextField1(
      title: 'Name',
      hintText: 'John Doe',
      controller: viewModel.nameController,
      validator: (value) {
        return Validator.validateDefaultField(value);
      },
      autoValidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget emailTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: CustomTextField1(
        title: 'Email',
        hintText: 'johndoe11@gmail.com',
        controller: viewModel.emailController,
        validator: (value) {
          return Validator.validateDefaultField(value);
        },
        autoValidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }

  Widget phoneNumberTextField() {
    return Obx(
      () => CountryCodePickerTextField2(
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
    );
  }

  Widget genderTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: CustomTextField1(
        title: 'Gender',
        hintText: 'Male',
        isDropDown: true,
        // controller: viewModel.emailController,
        validator: (value) {
          return Validator.validateDefaultField(value);
        },
        autoValidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }

  Widget passwordTextField() {
    return Obx(
      () => CustomTextField1(
        controller: viewModel.passwordController,
        title: 'Password',
        hintText: '● ● ● ● ● ● ● ● ● ●',
        validator: (value) {
          return Validator.validateDefaultField(value);
        },
        autoValidateMode: AutovalidateMode.onUserInteraction,
        obscureText: viewModel.obscurePassword.value ? true : false,
        suffixIconButton: ObscureSuffixIcon(
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
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: CustomTextField1(
          controller: viewModel.confirmPasswordController,
          title: 'Confirm Password',
          hintText: '● ● ● ● ● ● ● ● ● ●',
          validator: (value) {
            return Validator.validateDefaultField(value);
          },
          autoValidateMode: AutovalidateMode.onUserInteraction,
          obscureText: viewModel.obscurePassword.value ? true : false,
          suffixIconButton: ObscureSuffixIcon(
            isObscured: viewModel.obscurePassword.value ? true : false,
            onPressed: () {
              viewModel.obscurePassword.value = !viewModel.obscurePassword.value;
            },
          ),
        ),
      ),
    );
  }

  Widget cNICNumberField() {
    return CustomTextField1(
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        FilteringTextInputFormatter.digitsOnly,
      ],
      title: 'CNIC Number',
      hintText: '42101153225204',
      controller: viewModel.cnicController,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return Validator.validateDefaultField(value);
      },
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

  Widget signUpBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 5),
      child: CustomTextBtn(
        title: 'Save & Update',
        onPressed: () {},
      ),
    );
  }

  Widget discardBtn() {
    return CustomTextBtn(
      title: 'Discard',
      onPressed: () {},
      backgroundColor: Colors.black,
    );
  }
}
