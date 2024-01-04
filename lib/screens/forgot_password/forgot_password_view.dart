import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/languages/translations_key.dart';
import 'package:ismmart_vms/widgets/custom_text.dart';
import 'package:ismmart_vms/widgets/loader_view.dart';

import '../../helper/constants.dart';
import '../../helper/global_variables.dart';
import '../../helper/validator.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import 'forgot_password_viewModel.dart';

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({super.key});
  final ForgotPasswordViewModel viewModel = Get.put(ForgotPasswordViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(
          title: "Forget Password",
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Text("Forget Password",
                            style: newFontStyleSize24.copyWith(
                                color: newColorBlue))),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 52, bottom: 16),
                      child: Text('Reset Password', style: newFontStyleSize20),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 32),
                      child: Text(
                        'Enter Email account to reset your password',
                        style: newFontStyleSize14.copyWith(
                            color: newColorLightGrey2),
                      ),
                    ),
                    emailTextField(),
                    resetBtn()
                  ],
                ),
              ),
            ),
            const LoaderView()
          ],
        ),
      ),
    );
  }

  Widget emailTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 25),
      child: Form(
        key: viewModel.forgotPasswordFormKey,
        child: Column(
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: CustomText(
                  title: 'Email ',
                  style: newFontStyleSize14,
                )),
            const SizedBox(
              height: 16,
            ),
            CustomTextField2(
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
              controller: viewModel.emailController,
              prefixIcon: Icons.email,
              hintText: 'Email ',
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                return Validator.validateEmail(value);
              },
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),
      ),
    );
  }

  Widget resetBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: CustomRoundedTextBtn(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Reset",
                style: newFontStyleSize14.copyWith(
                    fontWeight: FontWeight.w500, color: kWhiteColor),
              ),
              const SizedBox(
                width: 4,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: const Icon(
                  Icons.arrow_forward,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
        onPressed: () {
          viewModel.sendBtn();
        },
      ),
    );
  }
}
