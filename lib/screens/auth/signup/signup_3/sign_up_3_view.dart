import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/models/bank_details_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismmart_vms/screens/auth/signup/signup_3/sign_up_3_viewmodel.dart';
import 'package:ismmart_vms/widgets/custom_checkbox.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:ismmart_vms/helper/constants.dart';
import 'package:ismmart_vms/widgets/custom_button.dart';
import 'package:ismmart_vms/widgets/custom_textfield.dart';

import '../../../../helper/global_variables.dart';
import '../../../../widgets/custom_loading.dart';
import '../signup_4/sign_up_4_view.dart';

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
                    const Divider(
                      color: Color(0xffEEEEEE),
                      thickness: 1,
                      height: 20,
                    ),

                    createAVendorAccount(),
                    progress(),
                    bankNameTextField(),
                    bankAccountTitleTextField(),
                    accountNumberTextField(),
                    bankAccountNumberTextField(),
                    bankAccountsList(context),
                    // Obx(() => branchCodeTextField()),
                    const SizedBox(height: 20),
                    addbanks(),
                    // addAccountBtn(),
                    singup3Btn(),
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
    return SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              'Sign Up',
              style: newFontStyleSize24,
            ),
          ),
          CustomBackButton(onTap: () {
            Get.back();
          }),
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

  Widget createAVendorAccount() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 54,
      ),
      child: Column(
        children: [
          Text(
            'Store information',
            style: newFontStyleSize20,
          ),
        ],
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
                        text: 'Profile Status',
                        style: newFontStyleSize14.copyWith(
                            color: newColorLightGrey2),
                      ),
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
            percent: 0.7,
            backgroundColor: Color(0xffEBEFF3),
            progressColor: newColorBlue,
            center: new Text(
              "3 of 4",
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
    return CustomTextField1(
      title: 'Bank Name',
      hintText: 'e.g Habib Bank',
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
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: CustomTextField1(
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

  Widget accountNumberTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 25),
      child: CustomTextField1(
        title: 'Account Number',
        hintText: '0319010******324',
        controller: viewModel.bankAccNumberController,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        // validator: (value) {
        //   return Validator().validateBankAcc(value);
        // },
        keyboardType: TextInputType.text,
      ),
    );
  }

  Widget bankAccountNumberTextField() {
    return CustomTextField1(
      title: 'IBAN',
      hintText: 'PK51MEZN0003190106294217',
      controller: viewModel.bankAccNumberController,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      // validator: (value) {
      //   return Validator().validateBankAcc(value);
      // },
      keyboardType: TextInputType.text,
    );
  }

  Widget addbanks() {
    return Align(
      alignment: Alignment.topLeft,
      child: Row(
        children: [
          IconButton(
              onPressed: null,
              icon: Icon(
                Icons.add,
                color: newColorBlue,
                size: 20,
              )),
          Text(
            'Add Multiple Banks',
            style: newFontStyleSize14.copyWith(
                fontWeight: FontWeight.w600, fontSize: 12, color: newColorBlue),
          ),
        ],
      ),
    );
    ;
  }

  Widget bankAccountsList(BuildContext context) {
    return Obx(
      () => viewModel.banksList.isEmpty
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: SizedBox(
                height: 50,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: viewModel.banksList,
                ),
              )),
    );
  }

  Widget addAccountBtn() {
    return CustomRoundedTextBtn(
      onPressed: () {
        viewModel.banksDetails.add(BankDetailsModel(
          accountNoOrIban: viewModel.bankAccNumberController.text,
          accountTitle: viewModel.bankAccTitleController.text,
          bankName: viewModel.bankNameController.text,
        ));
        viewModel.banksList.add(bankNameWidget(
            viewModel.bankNameController.text, viewModel.banksList.length));
        viewModel.banksList.refresh();
        viewModel.bankNameController.clear();
        viewModel.bankAccNumberController.clear();
        viewModel.bankAccTitleController.clear();
      },
      child: const Text(
        'Add Another Bank Account',
      ),
    );
  }

  Widget bankNameWidget(String bankName, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5),
      child: Container(
        width: 70,
        decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Center(
          child: Text(
            bankName,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Colors.grey.shade700),
          ),
        ),
      ),
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

  Widget singup3Btn() {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Obx(
        () => GlobalVariable.showLoader.value
            ? const CustomLoading(isItBtn: true)
            : CustomRoundedTextBtn(
                child: Text(
                  'Submit',
                  style: newFontStyleSize14.copyWith(
                      fontWeight: FontWeight.w500, color: kWhiteColor),
                ),
                onPressed: () {
                  Get.to(SignUp4View());
                },
              ),
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
                  style: newFontStyleSize14.copyWith(
                    color: newColorLightGrey2,
                  ),
                  children: [
                    const TextSpan(
                      text:
                          'By clicking ‘Create Account’, you’ve read and agreed to our ',
                    ),
                    TextSpan(
                      text: 'Terms and Conditions',
                      style: newFontStyleSize14.copyWith(
                        decoration: TextDecoration.underline,
                        color: newColorLightGrey2,
                      ),
                    ),
                    const TextSpan(
                      text:
                          ' and for my personal data to be processed according to',
                    ),
                    TextSpan(
                      text: ' ISMMART ',
                      style: newFontStyleSize14.copyWith(
                        color: newColorBlue2,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const TextSpan(text: 'Privacy Policy'),
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
