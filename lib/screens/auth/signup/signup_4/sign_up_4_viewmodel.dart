import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../helper/api_base_helper.dart';
import '../../../../helper/constants.dart';
import '../../../../helper/global_variables.dart';
import '../../../../helper/urls.dart';

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
