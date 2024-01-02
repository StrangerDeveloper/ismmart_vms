import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ismmart_vms/screens/store_profile/store_type_model.dart';

import '../../helper/api_base_helper.dart';
import '../../helper/common_function.dart';
import '../../helper/constants.dart';
import '../../helper/global_variables.dart';
import '../../helper/urls.dart';
import '../user_profile/user_profile_model.dart';

class StoreProfileViewModel extends GetxController {
  Rx<UserProfileModel> userProfileModel = UserProfileModel().obs;
  Rx<File> storeProfileImage = File('').obs;
  GlobalKey<FormState> storeFormKey = GlobalKey<FormState>();
  TextEditingController storeNameController = TextEditingController();
  TextEditingController storeSlugController = TextEditingController();
  List<StoreTypeModel> storeTypeList = <StoreTypeModel>[].obs;
  RxBool selectAllValue = false.obs;

  @override
  Future<void> onReady() async {
    await getStoreTypes();
    getUserData();
    super.onReady();
  }

  @override
  void onClose() {
    storeNameController.dispose();
    storeSlugController.dispose();
    GlobalVariable.showLoader.value = false;
    super.onClose();
  }

  selectAllItems() {
    selectAllValue.value = !selectAllValue.value;
    for (int i = 0; i < storeTypeList.length; i++) {
      StoreTypeModel model1 = storeTypeList[i];
      model1.isSelected = selectAllValue.value;
      storeTypeList[i] = model1;
    }
  }

  selectSingleItem(bool value, int index) {
    StoreTypeModel model1 = storeTypeList[index];
    model1.isSelected = value;
    storeTypeList[index] = model1;
  }

  getStoreTypes() async {
    GlobalVariable.showLoader.value = true;
    await ApiBaseHelper().getMethod(url: Urls.getStoreType).then((parsedJson) {
      GlobalVariable.showLoader.value = false;
      if (parsedJson['success'] == true &&
          parsedJson['data']['items'] != null) {
        var data = parsedJson['data']['items'] as List;
        storeTypeList.addAll(data.map((e) => StoreTypeModel.fromJson(e)));
      }
    }).catchError((e) {
      CommonFunction.debugPrint(e);
    });
  }

  getUserData() async {
    GlobalVariable.showLoader.value = true;
    await ApiBaseHelper().getMethod(url: Urls.getUserData).then((parsedJson) {
      GlobalVariable.showLoader.value = false;
      if (parsedJson['success'] == true &&
          parsedJson['message'] == "Profile fetched successuflly") {
        userProfileModel.value = UserProfileModel.fromJson(parsedJson['data']);
        storeNameController.text = userProfileModel.value.store?.name ?? '';
        storeSlugController.text = userProfileModel.value.store?.slug ?? '';

        userProfileModel.value.store?.types?.forEach((e) {
          int index = storeTypeList.indexWhere((e1) => e1.sId == e.sId);
          if (index >= 0) {
            StoreTypeModel model = storeTypeList[index];
            model.isSelected = true;
            storeTypeList[index] = model;
          }
        });
      }
    }).catchError((e) {
      CommonFunction.debugPrint(e);
    });
  }

  saveAndCreateBtn() async {
    if (storeFormKey.currentState?.validate() ?? false) {
      //storeType
      if (storeTypeList
          .where((element) => element.isSelected ?? false)
          .isEmpty) {
        AppConstant.displaySnackBar('Error', 'Please select Store Type');
        return;
      }

      //profileImage
      List<http.MultipartFile> fileList = [];
      if (storeProfileImage.value.path == '' &&
          userProfileModel.value.store?.logo == null) {
        AppConstant.displaySnackBar('Error', 'Please upload profile image');
        return;
      }

      if (storeProfileImage.value.path != '') {
        fileList.add(
          await http.MultipartFile.fromPath(
            'storeImage',
            storeProfileImage.value.path,
            // contentType: MediaType.parse('image/jpeg'),
          ),
        );
      }

      Map<String, String> param = {
        "storeName": storeNameController.text,
        "storeSlug": storeSlugController.text,
      };
      int index = 0;
      for (int i = 0; i < storeTypeList.length; i++) {
        if (storeTypeList[i].isSelected == true) {
          param["storeTypes[${index++}]"] = storeTypeList[i].sId!;
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
