import 'package:get/get.dart';

import '../../../../helper/api_base_helper.dart';
import '../../../../helper/common_function.dart';
import '../../../../helper/constants.dart';
import '../../../../helper/errors.dart';
import '../../../../helper/global_variables.dart';
import '../../../../helper/urls.dart';
import '../../../user_profile/user_profile_model.dart';
import '../../login/login_view.dart';

class AccountStatusViewModel extends GetxController{
  Rx<UserProfileModel> userProfileModel = UserProfileModel().obs;

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
      if (parsedJson['success'] == true && parsedJson['message'] == "Profile fetched successuflly") {
        userProfileModel.value = UserProfileModel.fromJson(parsedJson['data']);
      } else if (parsedJson['success'] == false && parsedJson['message'].toString().toLowerCase() == AppErrors.sessionException.toLowerCase()) {
        AppConstant.displaySnackBar('error', AppErrors.sessionException);
        Future.delayed(const Duration(seconds: 2), (){
          CommonFunction.logout();
        });
      }
    }).catchError((e) {
      CommonFunction.debugPrint(e);
    });
  }


}