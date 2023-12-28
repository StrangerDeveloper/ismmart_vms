import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismmart_vms/helper/utils/size_utils.dart';
import 'package:ismmart_vms/screens/auth/login/login_view.dart';
import 'package:ismmart_vms/screens/auth/signup/signup_4/sign_up_4_viewmodel.dart';
import 'package:ismmart_vms/widgets/scrollable_column.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../helper/constants.dart';
import '../../../../helper/global_variables.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_loading.dart';

class SignUp4View extends StatelessWidget {
  SignUp4View({super.key});
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
              SizedBox(height: 50.v),
              waitingVerificationText(),
              text1(),
              status()
            ],
          ),
        ),
      ),
    );
  }

  Widget titleAndBackBtn() {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              'ISMMART',
              style: GoogleFonts.dmSerifText(
                color: const Color(0xff333333),
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
                text: 'Submitted !',
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
                          text: 'Pending',
                          style: newFontStyleSize14.copyWith(
                            color: const Color(0xFFFFC120),
                          )),
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
            backgroundColor: const Color(0xffEBEFF3),
            progressColor: newColorBlue,
            center: Text(
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

  Widget progress1() {
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
                const SizedBox(height: 6),
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
              style: poppinsH2.copyWith(color: Colors.white, fontSize: 11),
            ),
          )
        ],
      ),
    );
  }

  Widget waitingVerificationText() {
    return Column(
      children: [
        Text(
          'Wait For Verification ...',
          style: newFontStyle3.copyWith(
            color: newColorDarkBlack,
          ),
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: newFontStyleSize14.copyWith(
              color: const Color(0xff667085),
              height: 1.5,
            ),
            children: [
              const TextSpan(text: 'Our'),
              TextSpan(
                text: ' Vendor Management Team ',
                style: newFontStyle2.copyWith(
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff0E1216),
                ),
              ),
              const TextSpan(
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
    );
  }

  Widget text1() {
    return Padding(
      padding: const EdgeInsets.only(top: 32, bottom: 100),
      child: Column(children: [
        RichText(
          maxLines: 50,
          textAlign: TextAlign.start,
          text: TextSpan(
            style: newFontStyleSize12.copyWith(
              color: newColorLightGrey3,
            ),
            children: [
              const TextSpan(
                  text:
                      'Vendor account rejections ISMMART market-place can occur due to various reasons, including:.\n\n'),
              TextSpan(
                  text: 'Incomplete Information:',
                  style:
                      newFontStyleSize12.copyWith(fontWeight: FontWeight.w700)),
              const TextSpan(
                text:
                    ' If the vendor application lacks necessary details or contains inaccurate information, it might lead to rejection.\n\n',
              ),
              TextSpan(
                  text: 'Unsatisfactory Product or Service:',
                  style:
                      newFontStyleSize12.copyWith(fontWeight: FontWeight.w700)),
              const TextSpan(
                text:
                    " The platform might have quality standards or guidelines that vendors need to meet. If the products or services don't match these standards, the account could be rejected.\n\n",
              ),
              TextSpan(
                  text: 'Legal or Compliance Issues:',
                  style:
                      newFontStyleSize12.copyWith(fontWeight: FontWeight.w700)),
              const TextSpan(
                text:
                    ' Failure to comply with legal requirements, such as missing licenses, certifications, or not meeting industry regulations, can lead to rejection.\n\n',
              ),
              TextSpan(
                  text: 'High Competition:',
                  style:
                      newFontStyleSize12.copyWith(fontWeight: FontWeight.w700)),
              const TextSpan(
                text:
                    ' In some cases, there might be too many similar vendors on the platform offering the same products or services. This oversaturation might result in rejection.\n\n',
              ),
              TextSpan(
                  text: 'Poor Reputation:',
                  style:
                      newFontStyleSize12.copyWith(fontWeight: FontWeight.w700)),
              const TextSpan(
                text:
                    ' Previous instances of poor customer service, negative reviews, or complaints against the vendor might influence the decision.\n\n',
              ),
              TextSpan(
                  text: 'Security Concerns:',
                  style:
                      newFontStyleSize12.copyWith(fontWeight: FontWeight.w700)),
              const TextSpan(
                text:
                    ' If the platform suspects potential security risks, fraud, or any form of malicious activity associated with the vendor, they might reject the account.\n\n',
              ),
              TextSpan(
                  text: 'Violation of Platform Policies:',
                  style:
                      newFontStyleSize12.copyWith(fontWeight: FontWeight.w700)),
              const TextSpan(
                text:
                    ' Not adhering to the terms of service or policies set by the e-commerce platform can lead to rejection.\n\n',
              ),
              TextSpan(
                  text: 'Financial Reasons:',
                  style:
                      newFontStyleSize12.copyWith(fontWeight: FontWeight.w700)),
              const TextSpan(
                text:
                    ' Issues related to financial stability, such as insufficient credit or financial history, may also result in rejection.',
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Widget status() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 100),
      child: Obx(
        () => GlobalVariable.showLoader.value
            ? const CustomLoading(isItBtn: true)
            : CustomRoundedTextBtn(
                child: Text(
                  'Go to Login ',
                  style: newFontStyleSize14.copyWith(
                      fontWeight: FontWeight.w500, color: kWhiteColor),
                ),
                onPressed: () {
                  Get.offAll(() => LogInView());
                },
              ),
      ),
    );
  }
}
