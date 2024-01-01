import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/widgets/custom_appbar.dart';
import 'package:ismmart_vms/widgets/custom_button.dart';
import 'package:ismmart_vms/widgets/custom_textfield.dart';
import 'package:ismmart_vms/widgets/image_layout_container.dart';
import 'package:ismmart_vms/widgets/loader_view.dart';
import 'package:path/path.dart';

import '../../helper/theme_helper.dart';
import '../../helper/validator.dart';
import '../../widgets/custom_bottom_sheet.dart';
import '../../widgets/pick_image.dart';
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
                        (viewModel.userProfileModel.value.status != null &&
                                viewModel.userProfileModel.value.status !=
                                    'Approved')
                            ? Column(
                                children: [
                                  cNICNumberField(),
                                  cNICFrontImage(),
                                  cNICBackImage(),
                                ],
                              )
                            : const SizedBox(),
                        updateBtn(),
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
                () => (viewModel.userProfileImage.value.path != "")
                    ? Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: FileImage(viewModel.userProfileImage.value),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : CachedNetworkImage(
                        height: 80,
                        width: 80,
                        imageUrl:    viewModel.userProfileModel.value.image !=
                            null
                            ? '${viewModel.userProfileModel.value.image}?datetime=${DateTime.now().millisecondsSinceEpoch}'
                            : '',
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
                onTap: () async {
                  viewModel.userProfileImage.value =
                      await PickImage().pickSingleImage() ?? File('');
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
          return Validator.validateEmail(value);
        },
        autoValidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }

  Widget phoneNumberTextField() {
    return CustomTextField1(
      title: 'Phone Number',
      hintText: '336 5563138',
      controller: viewModel.phoneNumberController,
      validator: (value) {
        return Validator().validatePhoneNumber(value);
      },
      autoValidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.phone,
    );
  }

  // Widget phoneNumberTextField() {
  //   return Obx(
  //     () => CountryCodePickerTextField(
  //       validator: (value) {
  //         return Validator().validatePhoneNumber(value);
  //       },
  //       title: 'Phone Number',
  //       hintText: '336 5563138',
  //       keyboardType: TextInputType.number,
  //       controller: viewModel.phoneNumberController,
  //       initialValue: viewModel.countryCode.value,
  //       textStyle:
  //           const TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
  //       autoValidateMode: AutovalidateMode.onUserInteraction,
  //       inputFormatters: [
  //         FilteringTextInputFormatter.allow(RegExp(r'^\d+?\d*')),
  //       ],
  //       errorText: viewModel.phoneErrorText.value,
  //       onPhoneFieldChange: (value) {
  //         String newPhoneValue = viewModel.countryCode.value + value;
  //         viewModel.validatorPhoneNumber(newPhoneValue);
  //       },
  //       onChanged: (value) {
  //         viewModel.countryCode.value = value.dialCode ?? '+92';
  //         String newPhoneValue = viewModel.countryCode.value +
  //             viewModel.phoneNumberController.text;
  //         viewModel.validatorPhoneNumber(newPhoneValue);
  //       },
  //     ),
  //   );
  // }

  Widget genderTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: CustomTextField1(
        title: 'Gender',
        hintText: 'Male',
        isDropDown: true,
        controller: viewModel.genderController,
        validator: (value) {
          return Validator.validateDefaultField(value);
        },
        autoValidateMode: AutovalidateMode.onUserInteraction,
        onTap: () {
          CustomBottomSheet1(
            selectedIndex: viewModel.genderSelectedIndex.value,
            list: viewModel.genderList,
            onChanged: (value) {
              viewModel.genderSelectedIndex.value = value;
              viewModel.genderController.text = viewModel.genderList[value];
            },
          ).show();
        },
      ),
    );
  }

  Widget cNICNumberField() {
    return CustomTextField1(
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      title: 'CNIC Number',
      hintText: '42101153225204',
      controller: viewModel.cNICNumberController,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return Validator.validateDefaultField(value);
      },
    );
  }

  Widget cNICFrontImage() {
    return Obx(() => Padding(
          padding: const EdgeInsets.only(top: 18, bottom: 2),
          child: ImageLayoutContainer(
            title: 'CNIC Front Image',
            filePath: basename(viewModel.cNICFrontImage.value.path),
            onTap: () async {
              viewModel.cNICFrontImage.value =
                  await PickImage().pickSingleImage() ?? File('');
            },
            errorVisibility: viewModel.showCNICFrontImageError.value,
            errorPrompt: 'CNIC Front Image is required',
          ),
        ));
  }

  Widget cNICBackImage() {
    return Obx(
      () => ImageLayoutContainer(
        title: 'CNIC Back Image',
        filePath: basename(viewModel.cNICBackImage.value.path),
        onTap: () async {
          viewModel.cNICBackImage.value = await PickImage().pickSingleImage() ?? File('');
        },
        errorVisibility: viewModel.showCNICBackImageError.value,
        errorPrompt: 'CNIC Back Image is required',
      ),
    );
  }

  Widget updateBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 5),
      child: CustomTextBtn(
        title: 'Save & Update',
        onPressed: () {
          viewModel.saveAndCreateBtn();
        },
      ),
    );
  }

  Widget discardBtn() {
    return CustomTextBtn(
      title: 'Discard',
      onPressed: () {
        Get.back();
      },
      backgroundColor: Colors.black,
    );
  }
}
