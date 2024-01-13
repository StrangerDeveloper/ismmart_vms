import 'package:get/get.dart';

class NotificationViewModel extends GetxController {
  @override
  void onInit() {
    var a = Get.arguments;
    print("payload====>$a");
    // TODO: implement onInit
    super.onInit();
  }
}
