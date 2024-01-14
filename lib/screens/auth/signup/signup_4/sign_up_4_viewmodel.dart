import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUp4ViewModel extends GetxController {
  RxMap<String, String> status = <String, String>{}.obs;
  TextEditingController emailController = TextEditingController();
  Map<String, dynamic> parsedJson = {};

  @override
  void onInit() async {
    status.value = Get.arguments ?? {};
    super.onInit();
  }

}
