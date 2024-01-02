import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/screens/bank_list/bank_list_viewmodel.dart';
import 'package:ismmart_vms/screens/bank_list/bank_model.dart';

import '../../helper/api_base_helper.dart';
import '../../helper/common_function.dart';
import '../../helper/constants.dart';
import '../../helper/global_variables.dart';
import '../../helper/urls.dart';

class AddBankViewModel extends GetxController {
  bool isEdit = false;
  BankModel bankModel = BankModel();
  GlobalKey<FormState> addBankFormKey = GlobalKey<FormState>();
  TextEditingController accountTitleController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController ibanController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  RxString accountTitle = 'Card Holder'.obs;
  RxString accountNumber = '0000 0000 0000 0000'.obs;
  RxString bankName = 'Meezan Bank'.obs;

  @override
  void onInit() {
    if (Get.arguments != null) {
      isEdit = Get.arguments['editData'];
    }
    super.onInit();
  }

  @override
  void onReady() {
    setData();
    super.onReady();
  }

  @override
  void onClose() {
    accountTitleController.dispose();
    accountNumberController.dispose();
    bankNameController.dispose();
    GlobalVariable.showLoader.value = false;
    super.onClose();
  }

  setData() {
    if (isEdit) {
      bankModel = Get.arguments['model'];
      accountTitleController.text = bankModel.title ?? '';
      accountTitle.value = bankModel.title ?? '';
      accountNumberController.text = bankModel.accountNumber ?? '';
      accountNumber.value = bankModel.accountNumber ?? '';
      ibanController.text = bankModel.iban ?? '';
      bankNameController.text = bankModel.name ?? '';
      bankName.value = bankModel.name ?? '';
    }
  }

  saveAndCreateBtn() async {
    if (addBankFormKey.currentState?.validate() ?? false) {

      Map<String, String> param = {
        "name": bankNameController.text,
        "title": accountTitleController.text,
        "iban": ibanController.text,
        "accountNumber": accountNumberController.text,
      };

      GlobalVariable.showLoader.value = true;
      if (isEdit) {
        await ApiBaseHelper()
            .putMethod(
            url: '${Urls.updateBank}${bankModel.sId}', body: param)
            .then((parsedJson) {
          GlobalVariable.showLoader.value = false;
          if (parsedJson['success'] == true && parsedJson['message'] == 'Bank Updated Successfully') {
            BankListViewModel viewModel = Get.find();
            viewModel.getData();
            Get.back();
            AppConstant.displaySnackBar('Success', parsedJson['message']);
          } else {
            AppConstant.displaySnackBar('Error', parsedJson['message']);
          }
        }).catchError((e) {
          CommonFunction.debugPrint(e);
        });
      } else {
        await ApiBaseHelper()
            .postMethod(url: Urls.addBank, body: param)
            .then((parsedJson) {
          GlobalVariable.showLoader.value = false;
          if (parsedJson['success'] == true && parsedJson['message'] == 'Bank added successfully') {
            BankListViewModel viewModel = Get.find();
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


}
