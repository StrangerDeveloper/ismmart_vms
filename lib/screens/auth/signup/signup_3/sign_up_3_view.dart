import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismmart_vms/screens/auth/signup/signup_3/sign_up_3_viewmodel.dart';
import 'package:ismmart_vms/widgets/custom_checkbox.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ismmart_vms/helper/global_variables.dart';

import 'package:ismmart_vms/helper/languages/translations_key.dart' as langKey;
import 'package:ismmart_vms/screens/auth/signup/signup_2/sign_up_2_view.dart';
import 'package:ismmart_vms/widgets/pick_image.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/constants.dart';
import 'package:ismmart_vms/widgets/image_layout_container.dart';
import 'package:path/path.dart';
import 'package:ismmart_vms/helper/theme_helper.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/global_variables.dart';
import 'package:ismmart_vms/helper/routes.dart';
import 'package:ismmart_vms/helper/validator.dart';
import 'package:ismmart_vms/widgets/custom_button.dart';
import 'package:ismmart_vms/widgets/custom_loading.dart';
import 'package:ismmart_vms/widgets/custom_text.dart';
import 'package:ismmart_vms/widgets/custom_textfield.dart';
import 'package:ismmart_vms/widgets/obscure_suffix_icon.dart';
import 'package:ismmart_vms/widgets/scrollable_column.dart';
import 'package:ismmart_vms/widgets/custom_button.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../login/login_view.dart';
import 'package:ismmart_vms/helper/languages/translations_key.dart' as langKey;

class SignUp3View extends StatelessWidget {
  SignUp3View({super.key});
  final SignUp3ViewModel viewModel = Get.put(SignUp3ViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              key: viewModel.vendorSignUp3FormKey,
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleAndBackBtn(),
                    // createAVendorAccount(),
                    progress(),
                    bankNameTextField(),
                    bankAccountTitleTextField(),
                    bankAccountNumberTextField(),
                    // Obx(() => branchCodeTextField()),
                    SizedBox(height: 20),
                    submitBtn(),
                  ],
                ),
              ),
            ),
          ),
          // NoInternetView(
          //   onPressed: () {
          //     viewModel.signUp();
          //   },
          // ),
        ],
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
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  // Widget createAVendorAccount() {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 20, bottom: 10),
  //     child: RichText(
  //       text: TextSpan(
  //         children: [
  //           TextSpan(
  //             text: langKey.add.tr,
  //             style: newFontStyle2.copyWith(
  //               fontSize: 20,
  //               color: newColorDarkBlack2,
  //             ),
  //           ),
  //           TextSpan(
  //             text: ' ${langKey.business.tr} ',
  //             style: newFontStyle2.copyWith(
  //               fontSize: 20,
  //               color: newColorBlue,
  //             ),
  //           ),
  //           TextSpan(
  //             text: langKey.information.tr,
  //             style: newFontStyle2.copyWith(
  //               fontSize: 20,
  //               color: newColorDarkBlack2,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

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
                // SizedBox(height: 6),
                // RichText(
                //   text: TextSpan(
                //     children: [
                //       TextSpan(
                //         text: langKey.next.tr + '  ',
                //         style: newFontStyle1.copyWith(
                //           fontSize: 12,
                //           color: newColorBlue4,
                //         ),
                //       ),
                //       TextSpan(
                //         text: langKey.profileStatus.tr,
                //         style: newFontStyle1.copyWith(
                //           fontSize: 12,
                //           color: newColorBlue3,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
          CircularPercentIndicator(
            circularStrokeCap: CircularStrokeCap.round,
            radius: 33,
            lineWidth: 6,
            percent: 0.75,
            backgroundColor: Color(0xffEBEFF3),
            progressColor: Color(0xff0CBC8B),
            center: new Text(
              "3 of 3",
              style: poppinsH2.copyWith(
                color: newColorBlue2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bankNameTextField() {
    return CustomTextField3(
      title: 'Bank Name',
      hintText: 'Enter Bank Name',
      controller: viewModel.bankNameController,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      // validator: (value) {
      //   return Validator().validateName(value, errorToPrompt: langKey.bankNameReq.tr);
      // },
      keyboardType: TextInputType.text,
    );
  }

  Widget bankAccountTitleTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: CustomTextField3(
        title: 'Account Title',
        hintText: 'Enter Account Title',
        controller: viewModel.bankAccTitleController,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        // validator: (value) {
        //   return Validator().validateName(value, errorToPrompt: langKey.bankAccHolderReq.tr);
        // },
        keyboardType: TextInputType.text,
      ),
    );
  }

  Widget bankAccountNumberTextField() {
    return CustomTextField3(
      title: 'Bank Account / IBAN',
      hintText: '123xxxxxxxxxxxx',
      controller: viewModel.bankAccNumberController,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      // validator: (value) {
      //   return Validator().validateBankAcc(value);
      // },
      keyboardType: TextInputType.text,
    );
  }

  // Widget branchCodeTextField() {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 25.0),
  //     child: CustomTextField3(
  //       enabled: viewModel.enableBranchCode.value,
  //         required: false,
  //         title: langKey.branchCode.tr,
  //         inputFormatters: [
  //           FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
  //           FilteringTextInputFormatter.digitsOnly,
  //         ],
  //         hintText: langKey.enterBranchCode.tr,
  //         controller: viewModel.branchCodeController,
  //         autoValidateMode: AutovalidateMode.onUserInteraction,
  //         // validator: (value) {
  //         //   return Validator().validateBranchCode(value, viewModel.bankAccNumberController.text);
  //         // },
  //         keyboardType: TextInputType.number,
  //       ),
  //     );
  // }

  // Widget addBtn() {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(vertical: 20),
  //     child: ,
  //   )
  // }

  Widget submitBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 25),
      child: CustomRoundedTextBtn(
        title: 'Submit',
        onPressed: () async {
          await viewModel.signUp();
          // Get.to(() => VendorSignUp3View());
        },
      ),
    );
  }

  Widget checkBoxTermCondition() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(bottom: 25, top: 5),
        child: CustomCheckBox2(
          value: viewModel.termAndCondition.value,
          onChanged: (value) {
            viewModel.termAndCondition.value = value;
          },
          text: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: InkWell(
              onTap: () {
                // showTermsAndConditionDialog();
              },
              child: RichText(
                text: TextSpan(
                  style: newFontStyle0.copyWith(
                    color: newColorLightGrey2,
                  ),
                  children: [
                    TextSpan(
                      text:
                          'By clicking ‘Create Account’, you’ve read and agreed to our ',
                    ),
                    TextSpan(
                      text: 'Terms and Conditions',
                      style: newFontStyle0.copyWith(
                        decoration: TextDecoration.underline,
                        color: newColorLightGrey2,
                      ),
                    ),
                    TextSpan(
                      text:
                          ' and for my personal data to be processed according to',
                    ),
                    TextSpan(
                      text: ' ISMMART ',
                      style: newFontStyle0.copyWith(
                        color: newColorBlue2,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(text: 'Privacy Policy'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Future showTermsAndConditionDialog() async {
  //   return showDialog(
  //     barrierDismissible: true,
  //     context: Get.context!,
  //     builder: (BuildContext context) {
  //       return Dialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(8),
  //         ),
  //         insetPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
  //         child: Stack(
  //           alignment: Alignment.topRight,
  //           children: [
  //             SingleChildScrollView(
  //               padding: EdgeInsets.only(top: 20),
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   Text(
  //                     'Terms & conditions',
  //                     style: headline1.copyWith(
  //                       fontSize: 20,
  //                       fontWeight: FontWeight.w800,
  //                     ),
  //                   ),
  //                   Divider(),
  //                   Padding(
  //                     padding: const EdgeInsets.fromLTRB(18, 0, 22, 16),
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: viewModel.getTermConditionData().map((e) {
  //                         return Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                           children: [
  //                             AppConstant.spaceWidget(height: 15),
  //                             if (e['header'] != '')
  //                               CustomText(
  //                                 title: "${e['header']}",
  //                                 style: headline2.copyWith(
  //                                   fontSize: 17,
  //                                 ),
  //                               ),
  //                             if (e['header'] != '') Divider(),
  //                             if (e['body'].toString().isNotEmpty)
  //                               Text(
  //                                 "${e['body'].toString()}",
  //                                 style: GoogleFonts.poppins(
  //                                   fontSize: 13.5,
  //                                   color: kDarkColor,
  //                                   height: 1.7,
  //                                 ),
  //                               ),
  //                           ],
  //                         );
  //                       }).toList(),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //
  //             IconButton(
  //               onPressed: () {
  //                 Get.back();
  //               },
  //               icon: Icon(Icons.close),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}
