import 'dart:io';

import 'package:get/get.dart';

class UserProfileViewModel extends GetxController{
  Rx<File> pickedFile = File('').obs;
}
