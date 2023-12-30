import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
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
  TextEditingController storeTypeController = TextEditingController();

  @override
  void onReady() {
    getUserData();
    getStoreTypes();
    super.onReady();
  }

  @override
  void onClose() {
    storeNameController.dispose();
    storeSlugController.dispose();
    storeTypeController.dispose();
    // searchController.dispose();
    GlobalVariable.showLoader.value = false;
    super.onClose();
  }

  ///////////
  // List<StoreTypeModel> allStoreTypeList = <StoreTypeModel>[].obs;
  List<StoreTypeModel> filteredStoreTypeList = <StoreTypeModel>[].obs;
  TextEditingController searchController = TextEditingController();
  RxBool selectAllValue = false.obs;

  selectAllItems() {
    selectAllValue.value = !selectAllValue.value;

    for (int i = 0; i < filteredStoreTypeList.length; i++) {
      StoreTypeModel model1 = filteredStoreTypeList[i];
      model1.isSelected = selectAllValue.value;
      filteredStoreTypeList[i] = model1;
    }
  }

  selectSingleItem(bool value, int index) {
    StoreTypeModel model1 = filteredStoreTypeList[index];
    model1.isSelected = value;
    filteredStoreTypeList[index] = model1;
  }

  // resetForCitiesCountryValue({bool isCity = false}) {
  //   searchController.text = '';
  //   filteredStoreTypeList.clear();
  //   filteredStoreTypeList.addAll(allStoreTypeList);
  // }
  //
  // onSearchForCitiesCountries(String value, {bool isCity = false}) {
  //   filteredStoreTypeList.clear();
  //   filteredStoreTypeList.addAll(allStoreTypeList.where((e) => e.name?.toLowerCase().contains(value.toLowerCase()) ?? false));
  // }
  //////////////

  getStoreTypes() async {
    GlobalVariable.showLoader.value = true;
    await ApiBaseHelper().getMethod(url: Urls.getStoreType).then((parsedJson) {
      GlobalVariable.showLoader.value = false;
      if (parsedJson['success'] == true &&
          parsedJson['data']['items'] != null) {
        var data = parsedJson['data']['items'] as List;
        filteredStoreTypeList
            .addAll(data.map((e) => StoreTypeModel.fromJson(e)));
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
      }
    }).catchError((e) {
      CommonFunction.debugPrint(e);
    });
  }

  saveAndCreateBtn() async {
    if (storeFormKey.currentState?.validate() ?? false) {
      //storeType
      if (filteredStoreTypeList
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
            'image',
            storeProfileImage.value.path,
            contentType: MediaType.parse('image/jpeg'),
          ),
        );
      }

      Map<String, String> param = {
        "storeName": storeNameController.text,
        "storeSlug": storeSlugController.text,
        for (int i = 0; i < filteredStoreTypeList.length; i++)
          "storeTypes[$i]": filteredStoreTypeList[i].sId!
      };

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
