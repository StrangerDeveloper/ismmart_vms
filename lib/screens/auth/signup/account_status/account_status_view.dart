import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismmart_vms/helper/theme_helper.dart';
import 'package:ismmart_vms/helper/utils/size_utils.dart';
import 'package:ismmart_vms/screens/auth/signup/account_status/account_status_viewmodel.dart';
import 'package:ismmart_vms/screens/auth/signup/signup_4/sign_up_4_viewmodel.dart';
import 'package:ismmart_vms/screens/setting/settings_view.dart';
import 'package:ismmart_vms/widgets/custom_drawer.dart';
import 'package:ismmart_vms/widgets/loader_view.dart';
import 'package:ismmart_vms/widgets/scrollable_column.dart';

import '../../../../../helper/constants.dart';
import '../../../../../widgets/custom_button.dart';

class AccountStatusView extends StatelessWidget {
  AccountStatusView({super.key});
  final SignUp4ViewModel viewModel = Get.put(SignUp4ViewModel());
  final AccountStatusViewModel viewModel2 = Get.put(AccountStatusViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 25, right: 25),
              child: ScrollableColumn(
                children: [
                  titleAndBackBtn(),
                  subtitle(),
                  progress(),
                  SizedBox(height: 50.h),
                  waitingVerificationText(),
                  const SizedBox(
                    height: 50,
                  ),
                  emailVerifyText(),
                  requestBtn()
                ],
              ),
            ),
            const LoaderView()
          ],
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
      alignment: Alignment.center,
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
                text: 'Submitted' '!',
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
      padding: const EdgeInsets.only(bottom: 42, top: 20),
      child: Row(
        children: [
          Expanded(
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                            text: viewModel.status['status'],
                            style: newFontStyleSize14.copyWith(
                                color: ThemeHelper.red1)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // CircularPercentIndicator(
          //   circularStrokeCap: CircularStrokeCap.round,
          //   radius: 33,
          //   lineWidth: 6,
          //   percent: 1,
          //   backgroundColor: const Color(0xffEBEFF3),
          //   progressColor: newColorBlue,
          //   center: Text(
          //     "4 of 4",
          //     style: poppinsH2.copyWith(
          //       color: newColorBlue2,
          //     ),
          //   ),
          // ),
          //
        ],
      ),
    );
  }

  Widget waitingVerificationText() {
    return Obx(
      () => Column(
        children: [
          Text(
            viewModel.status['status'] == "Rejected"
                ? 'Reason for rejection'
                : viewModel.status['status'] == 'Not Verified'
                    ? 'Reason for Not Verified'
                    : 'Reason for Pending',
            style: newFontStyle3.copyWith(
              color: newColorBlue,
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
                const TextSpan(
                  text: 'Due to ',
                ),
                TextSpan(
                  text: viewModel.status['status'] == "Rejected"
                      ? 'Incomplete Information'
                      : viewModel.status['status'] == 'Not Verified'
                          ? 'Not Verify Your Email'
                          : 'Pending your Request',
                  style: newFontStyle2.copyWith(
                    fontWeight: FontWeight.w700,
                    color: ThemeHelper.red1,
                  ),
                ),
                const TextSpan(
                    text:
                        ' vendor application lacks necessary details or contains inaccurate information, it might lead to rejection.'),
                TextSpan(text: viewModel.status['remarks'] ?? '')
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget emailVerifyText() {
    return Obx(
      () => viewModel.status['status'] == 'Rejected'
          ? const SizedBox()
          : viewModel.status['status'] == 'Not Verified'
              ? Column(
                  children: [
                    const Text(
                      "Email send on",
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: newFontStyleSize14.copyWith(
                          color: const Color(0xff667085),
                          height: 1.5,
                        ),
                        children: [
                          TextSpan(
                            text: viewModel.status['email'] ?? "",
                            style: newFontStyle2.copyWith(
                              fontWeight: FontWeight.w700,
                              color: ThemeHelper.red1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
    );
  }

  Widget requestBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Obx(
        () => viewModel.status['status'] == 'Rejected'
            ? CustomRoundedTextBtn(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Go to Settings ',
                        style: newFontStyleSize14.copyWith(
                            fontWeight: FontWeight.w500, color: kWhiteColor),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const Icon(
                      Icons.sync,
                      size: 25,
                      color: Colors.green,
                    ),
                  ],
                ),
                onPressed: () {
                  Get.to(()=>SettingsView());
                },
              )
            : viewModel.status['status'] == 'Not Verified'
                ? CustomRoundedTextBtn(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            ' Resent Verification Email ',
                            style: newFontStyleSize14.copyWith(
                                fontWeight: FontWeight.w500,
                                color: kWhiteColor),
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        const Icon(
                          Icons.sync,
                          size: 25,
                          color: Colors.green,
                        ),
                      ],
                    ),
                    onPressed: () {
                      viewModel.resentEmail();
                    },
                  )
                : const SizedBox(),
      ),
    );
  }
}
