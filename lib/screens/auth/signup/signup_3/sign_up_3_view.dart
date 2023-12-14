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
                    bankAccountsList(context),
                    // Obx(() => branchCodeTextField()),
                    const SizedBox(height: 20),
                    addAccountBtn(),
                    submitBtn(),
                    checkBoxTermCondition(),
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
                color: const Color(0xff333333),
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
            backgroundColor: const Color(0xffEBEFF3),
            progressColor: const Color(0xff0CBC8B),
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

  Widget bankAccountsList(BuildContext context) {
    return Obx(() => viewModel.banksList.isEmpty ? const SizedBox() : Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
        child: SizedBox(
          height: 50,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: viewModel.banksList,
          ),
        )
        ),
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
          viewModel.banksList.add(bankNameWidget(viewModel.bankNameController.text, viewModel.banksList.length));
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
            borderRadius: const BorderRadius.all(Radius.circular(8))
        ),
        child: Center(
          child: Text(
            bankName,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Colors.grey.shade700
            ),
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

  Widget submitBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 10),
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
                    const TextSpan(
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
                    const TextSpan(
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
