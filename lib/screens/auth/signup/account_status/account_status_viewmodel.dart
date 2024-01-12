import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../helper/api_base_helper.dart';
import '../../../../helper/common_function.dart';
import '../../../../helper/constants.dart';
import '../../../../helper/errors.dart';
import '../../../../helper/global_variables.dart';
import '../../../../helper/urls.dart';
import '../../../user_profile/user_profile_model.dart';

class AccountStatusViewModel extends GetxController {
  Rx<UserProfileModel> userProfileModel = UserProfileModel().obs;
  RxString accountIsPending = ''.obs;

  @override
  void onInit() {
    accountIsPending.value = GetStorage().read('status');
    super.onInit();
  }

  @override
  void onReady() {
    getData();
    super.onReady();
  }

  @override
  void onClose() {
    GlobalVariable.showLoader.value = false;
    super.onClose();
  }

  getData() async {
    GlobalVariable.showLoader.value = true;
    await ApiBaseHelper().getMethod(url: Urls.getUserData).then((parsedJson) {
      GlobalVariable.showLoader.value = false;
      if (parsedJson['success'] == true &&
          parsedJson['message'] == "Profile fetched successuflly") {
        userProfileModel.value = UserProfileModel.fromJson(parsedJson['data']);
      } else if (parsedJson['success'] == false && parsedJson['message'].toString().toLowerCase() == AppErrors.sessionException.toLowerCase()) {
        AppConstant.displaySnackBar('error', AppErrors.sessionException);
        Future.delayed(const Duration(seconds: 2), () {
          CommonFunction.logout();
        });
      }
    }).catchError((e) {
      CommonFunction.debugPrint(e);
    });
  }

  void resentEmail() async {
    Map<String, dynamic> param = {"email": userProfileModel.value.email};
    GlobalVariable.showLoader.value = true;

    await ApiBaseHelper()
        .postMethod(url: Urls.resendEmail, body: param)
        .then((parsedJson) {
      GlobalVariable.showLoader.value = false;
      if (parsedJson['success'] == true) {
        AppConstant.displaySnackBar(
            "success", "Reset Password Link send to your Email");
      } else {
        AppConstant.displaySnackBar("Error", "Failed To Send Email");
      }
    }).catchError((e) {
      CommonFunction.debugPrint(e);
    });
  }
}
