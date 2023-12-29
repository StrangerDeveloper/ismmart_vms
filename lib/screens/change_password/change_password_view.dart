import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/screens/change_password/change_password_viewmodel.dart';

import '../../helper/validator.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/loader_view.dart';
import '../../widgets/obscure_suffix_icon.dart';

class ChangePasswordView extends StatelessWidget {
  ChangePasswordView({super.key});
  final ChangePasswordViewModel viewModel = Get.put(ChangePasswordViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar2(
        title: 'Change Password',
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  // key: viewModel.userProfileFormKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        passwordTextField(),
                        confirmPasswordTextField(),
                        updateBtn(),
                        discardBtn(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const LoaderView(),
        ],
      ),
    );
  }

  Widget passwordTextField() {
    return Obx(
          () => CustomTextField1(
        controller: viewModel.passwordController,
        title: 'Password',
        hintText: '● ● ● ● ● ● ● ● ● ●',
        // validator: (value) {
        //   return Validator.validatePassword(value);
        // },
        // autoValidateMode: AutovalidateMode.onUserInteraction,
        obscureText: viewModel.obscurePassword.value ? true : false,
        suffixIconButton: ObscureSuffixIcon(
          isObscured: viewModel.obscurePassword.value ? true : false,
          onPressed: () {
            viewModel.obscurePassword.value = !viewModel.obscurePassword.value;
          },
        ),
      ),
    );
  }

  Widget confirmPasswordTextField() {
    return Obx(
          () => Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: CustomTextField1(
          controller: viewModel.confirmPasswordController,
          title: 'Confirm Password',
          hintText: '● ● ● ● ● ● ● ● ● ●',
          validator: (value) {
            return Validator.validateConfirmPassword(
                value, viewModel.passwordController.text);
          },
          // autoValidateMode: AutovalidateMode.onUserInteraction,
          obscureText: viewModel.obscureConfirmPassword.value ? true : false,
          suffixIconButton: ObscureSuffixIcon(
            isObscured: viewModel.obscureConfirmPassword.value ? true : false,
            onPressed: () {
              viewModel.obscureConfirmPassword.value =
              !viewModel.obscureConfirmPassword.value;
            },
          ),
        ),
      ),
    );
  }

  Widget updateBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 5),
      child: CustomTextBtn(
        title: 'Save & Update',
        onPressed: () {},
      ),
    );
  }

  Widget discardBtn() {
    return CustomTextBtn(
      title: 'Discard',
      onPressed: () {
        Get.back();
      },
      backgroundColor: Colors.black,
    );
  }



}
