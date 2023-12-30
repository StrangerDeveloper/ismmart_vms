import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:ismmart_vms/helper/global_variables.dart';

import '../../helper/api_base_helper.dart';
import '../../helper/common_function.dart';
import '../../helper/constants.dart';
import '../../helper/urls.dart';
import '../user_profile/user_profile_model.dart';
import '../user_profile/user_profile_viewmodel.dart';

class EditUserProfileViewModel extends GetxController {
  Rx<File> userProfileImage = File('').obs;
  Rx<File> cNICFrontImage = File('').obs;
  Rx<File> cNICBackImage = File('').obs;
  Rx<UserProfileModel> userProfileModel = UserProfileModel().obs;
  GlobalKey<FormState> userProfileFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController cNICNumberController = TextEditingController();
  RxBool showCNICFrontImageError = false.obs;
  RxBool showCNICBackImageError = false.obs;

  //Gender
  RxInt genderSelectedIndex = (-1).obs;
  List genderList = ['Male', 'Female', 'Other'];

  //phoneNumber
  Rxn phoneErrorText = Rxn<String>();
  RxString countryCode = '+92'.obs;

  @override
  void onInit() {
    userProfileModel = Get.arguments['model'];
    super.onInit();
  }

  @override
  void onReady() {
    setData();
    super.onReady();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    genderController.dispose();
    cNICNumberController.dispose();
    GlobalVariable.showLoader.value = false;
    super.onClose();
  }

  // validatorPhoneNumber(String? value) {
  //   if (GetUtils.isBlank(value)!) {
  //     phoneErrorText.value = 'Field required';
  //   } else if (value!.length > 16 || value.length < 7) {
  //     phoneErrorText.value = 'Phone numbers should be 7 to 16 digits long.';
  //   } else {
  //     phoneErrorText.value = null;
  //   }
  // }

  setData() {
    nameController.text = userProfileModel.value.name ?? '';
    emailController.text = userProfileModel.value.email ?? '';
    phoneNumberController.text = userProfileModel.value.phone ?? '';
    genderController.text = userProfileModel.value.gender ?? '';
    genderSelectedIndex.value = genderList.indexOf(userProfileModel.value.gender ?? '');
    cNICNumberController.text = userProfileModel.value.cnic ?? '';
  }

  saveAndCreateBtn() async {
    if (userProfileFormKey.currentState?.validate() ?? false) {
      List<http.MultipartFile> fileList = [];
      //profileImage
      if (userProfileImage.value.path == '' && userProfileModel.value.image == null) {
        AppConstant.displaySnackBar('Error', 'Please upload profile image');
        return;
      }
      if (userProfileImage.value.path != '') {
        fileList.add(
          await http.MultipartFile.fromPath(
            'image',
            userProfileImage.value.path,
            contentType: MediaType.parse('image/jpeg'),
          ),
        );
      }

      Map<String, String> param = {
        "name": nameController.text,
        "email": emailController.text,
        "phone": phoneNumberController.text,
        "gender": genderList[genderSelectedIndex.value],
      };

      //CNIC
      if (userProfileModel.value.status != null && userProfileModel.value.status != 'Approved') {

        param['cnic'] = cNICNumberController.text;

        if (cNICFrontImage.value.path == '' || cNICBackImage.value.path == '') {
          AppConstant.displaySnackBar(
              'Error', 'Please upload cnic back and front image');
          return;
        }

        if (cNICFrontImage.value.path != '') {
          fileList.add(
            await http.MultipartFile.fromPath(
              'cnicImages[0]',
              cNICFrontImage.value.path,
              contentType: MediaType.parse('image/jpeg'),
            ),
          );
        }

        if (cNICBackImage.value.path != '') {
          fileList.add(
            await http.MultipartFile.fromPath(
              'cnicImages[1]',
              cNICBackImage.value.path,
              contentType: MediaType.parse('image/jpeg'),
            ),
          );
        }
      }



      GlobalVariable.showLoader.value = true;
      await ApiBaseHelper()
          .putMethodForImage(
              url: Urls.updateUserData, files: fileList, fields: param)
          .then((parsedJson) {
        GlobalVariable.showLoader.value = false;
        if (parsedJson['success'] == true &&
            parsedJson['message'] == 'Profile updated successuflly') {
          UserProfileViewModel viewModel = Get.find();
          viewModel.getData();
          Get.back();
          AppConstant.displaySnackBar('Success', parsedJson['message']);
        } else {
          AppConstant.displaySnackBar('Error', parsedJson['message']);
        }
      }).catchError((e) {
        CommonFunction.debugPrint(e);
      });
    }
  }
}
