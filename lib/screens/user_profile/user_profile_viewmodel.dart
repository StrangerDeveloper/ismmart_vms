import 'package:get/get.dart';
import 'package:ismmart_vms/screens/user_profile/user_profile_model.dart';

import '../../helper/api_base_helper.dart';
import '../../helper/common_function.dart';
import '../../helper/global_variables.dart';
import '../../helper/urls.dart';

class UserProfileViewModel extends GetxController {
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
      if (parsedJson['success'] == true &&
          parsedJson['message'] == "Profile fetched successuflly") {
        userProfileModel.value = UserProfileModel.fromJson(parsedJson['data']);
      }
    }).catchError((e) {
      CommonFunction.debugPrint(e);
    });
  }
}
