import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismmart_vms/helper/theme_helper.dart';
import 'package:ismmart_vms/screens/auth/login/login_view.dart';
import 'package:ismmart_vms/screens/auth/signup/signup_4/sign_up_4_viewmodel.dart';
import 'package:ismmart_vms/widgets/scrollable_column.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../helper/constants.dart';
import '../../../../widgets/custom_button.dart';
import '../../../helper/global_variables.dart';
import '../../../widgets/custom_loading.dart';

class AccountStatusView extends StatelessWidget {
  AccountStatusView({Key? key}) : super(key: key);
  final SignUp4ViewModel viewModel = Get.put(SignUp4ViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 30, left: 25, right: 25),
          child: ScrollableColumn(
            children: [
              titleAndBackBtn(),
              subtitle(),
              progress(),
              SizedBox(height: 50),
              waitingVerificationText(),
              requestBtn()
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
          Image.asset(
            'assets/icons/ismmart_logo.png',
            height: 40,
            width: 40,
          )
        ],
      ),
    );
  }

  Widget subtitle() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 80,
        ),
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
      padding: const EdgeInsets.only(bottom: 42),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(height: 6),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Next Step: ',
                        style: newFontStyleSize14,
                      ),
                      TextSpan(
                          text: 'Rejected',
                          style: newFontStyleSize14.copyWith(
                              color: ThemeHelper.red1)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          CircularPercentIndicator(
            circularStrokeCap: CircularStrokeCap.round,
            radius: 33,
            lineWidth: 6,
            percent: 1,
            backgroundColor: Color(0xffEBEFF3),
            progressColor: newColorBlue,
            center: new Text(
              "4 of 4",
              style: poppinsH2.copyWith(
                color: newColorBlue2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget waitingVerificationText() {
    return Column(
      children: [
        Text(
          'Reason for rejection',
          style: newFontStyle3.copyWith(
            color: newColorBlue,
          ),
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: newFontStyleSize14.copyWith(
              color: Color(0xff667085),
              height: 1.5,
            ),
            children: [
              TextSpan(
                text: 'Due to ',
              ),
              TextSpan(
                text: 'Incomplete Information',
                style: newFontStyle2.copyWith(
                  fontWeight: FontWeight.w700,
                  color: ThemeHelper.red1,
                ),
              ),
              TextSpan(
                  text:
                      ' vendor application lacks necessary details or contains inaccurate information, it might lead to rejection.'),
            ],
          ),
        ),
      ],
    );
  }

  Widget requestBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 90),
      child: Obx(
        () => GlobalVariable.showLoader.value
            ? const CustomLoading(isItBtn: true)
            : CustomRoundedTextBtn(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Request again',
                      style: newFontStyleSize14.copyWith(
                          fontWeight: FontWeight.w500, color: kWhiteColor),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Icon(
                      Icons.sync,
                      size: 20,
                    ),
                  ],
                ),
                onPressed: () {
                  Get.offAll(LogInView());
                },
              ),
      ),
    );
  }
}
