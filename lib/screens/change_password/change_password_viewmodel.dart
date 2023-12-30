import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordViewModel extends GetxController{
  GlobalKey<FormState> userProfileFormKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RxBool obscurePassword = true.obs;
  RxBool obscureConfirmPassword = true.obs;
}