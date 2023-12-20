import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismmart_vms/screens/auth/login/login_view.dart';
import 'package:ismmart_vms/screens/auth/signup/signup_4/sign_up_4_viewmodel.dart';

import '../../../../helper/constants.dart';
import '../../../../widgets/custom_button.dart';

class SignUp4View extends StatelessWidget {
  SignUp4View({Key? key}) : super(key: key);
  final SignUp4ViewModel viewModel = Get.put(SignUp4ViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
          child: Column(
            children: [
              titleAndBackBtn(),
              subtitle(),
              progress(),
              SizedBox(height: 35),
              Text(
                'Wait For Verification ...',
                style: newFontStyle3.copyWith(
                  color: newColorDarkBlack,
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: newFontStyle0.copyWith(
                    color: Color(0xff667085),
                    height: 1.5,
                  ),
                  children: [
                    TextSpan(text: 'Our'),
                    TextSpan(
                      text: ' Vendor Management Team ',
                      style: newFontStyle2.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Color(0xff0E1216),
                      ),
                    ),
                    TextSpan(
                      text:
                      'will review your profile and after approval you will receive a confirmation email of your',
                    ),
                    TextSpan(
                      text: ' seller account',
                      style: newFontStyle2.copyWith(
                        fontWeight: FontWeight.w700,
                        color: newColorBlue2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleAndBackBtn() {
    return Container(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              'ISMMART',
              style: GoogleFonts.dmSerifText(
                color: Color(0xff333333),
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          CustomBackButton(
            onTap: () {
              Get.to(() => LogInView());
              // if(viewModel.fromSettings.value){
              //   Get.back();
              // } else {
              //   baseController.changePage(0);
              //   int count = 0;
              //   Get.until((route) => count++ >= 2);
              //   // Get.offNamedUntil(Routes.bottomNavigation, (route) => false);
              // }
            },
          ),
        ],
      ),
    );
  }

  Widget subtitle() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Vendor',
                style: newFontStyle2.copyWith(
                  fontSize: 20,
                  color: newColorDarkBlack2,
                ),
              ),
              TextSpan(
                text: ' Profile ',
                style: newFontStyle2.copyWith(
                  fontSize: 20,
                  color: newColorBlue,
                ),
              ),
              TextSpan(
                text: 'Submitted' + '!',
                style: newFontStyle2.copyWith(
                  fontSize: 20,
                  color: newColorDarkBlack2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget progress() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 30),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Vendor Account Creation',
                  style: newFontStyle1.copyWith(
                    color: newColorBlue2,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Last Step',
                  style: newFontStyle1.copyWith(
                    fontSize: 12,
                    color: newColorBlue4,
                  ),
                ),
              ],
            ),
          ),
          CircleAvatar(
            radius: 40,
            backgroundColor: const Color(0xff0CBC8B),
            child: Text(
              'Completed',
              style: poppinsH2.copyWith(
                color: Colors.white,
                fontSize: 11
              ),
            ),
          )
        ],
      ),
    );
  }
}