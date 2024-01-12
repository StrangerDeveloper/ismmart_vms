import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ismmart_vms/helper/global_variables.dart';

import '../auth/login/login_view.dart';
import '../auth/signup/account_status/account_status_view.dart';
import '../drawer_bottom_nav/drawer_bottom_bar_view.dart';

class SplashScreenViewModel extends GetxController {



  @override
  void onReady() {
    Future.delayed(const Duration(seconds: 4), () {
      print('object1111');
      navigateToNextScreen();
    });
    super.onReady();
  }

  navigateToNextScreen() {
    print('object');
    String userStatus = GetStorage().read('status') ?? '';
    GlobalVariable.token = GetStorage().read('token') ?? '';
    print('object');
    print(userStatus);
    print(GlobalVariable.token);

    if (userStatus != 'Approved' && GlobalVariable.token != '') {
      Get.offAll(() => AccountStatusView());
    } else if (GlobalVariable.token != '') {
      Get.offAll(() => DrawerBottomBarView());
    } else {
      Get.to(() => LogInView());
    }
  }
}
