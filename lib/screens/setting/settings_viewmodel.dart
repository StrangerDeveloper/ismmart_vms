import 'package:get/get.dart';

import '../user_profile/user_profile_model.dart';

class SettingViewModel extends GetxController {
  Rx<UserProfileModel> userProfileModel = UserProfileModel().obs;

  @override
  void onInit() {
    userProfileModel.value = Get.arguments['model'];
    super.onInit();
  }
}
