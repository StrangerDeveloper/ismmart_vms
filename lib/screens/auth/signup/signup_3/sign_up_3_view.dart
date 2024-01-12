import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/utils/size_utils.dart';
import 'package:ismmart_vms/models/bank_details_model.dart';
import 'package:ismmart_vms/screens/auth/signup/signup_3/sign_up_3_viewmodel.dart';
import 'package:ismmart_vms/widgets/loader_view.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:ismmart_vms/helper/constants.dart';
import 'package:ismmart_vms/widgets/custom_button.dart';
import 'package:ismmart_vms/widgets/custom_textfield.dart';

import '../../../../helper/theme_helper.dart';
import '../../../../helper/validator.dart';
import '../../../add_bank/add_bank_view.dart';

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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 1),
                      child: CustomTextField1(
                        title: 'Bank Name',
                        hintText: 'e.g Habib Bank',
                        controller: viewModel.bankController,
                        // isDropDown: true,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (viewModel.bankController.text == '') {
                            return Validator.validateDefaultField(value,
                                errorMessage: 'Bank Name is Required');
                          } else {
                            return null;
                          }
                        },
                        onTap: () {
                          // viewModel.getBankList();
                          // // viewModel.resetValue();
                          //
                          // itemsBottomSheet();
                        },
                      ),
                    ),
                    bankAccountTitleTextField(),
                    accountNumberTextField(),
                    bankIBANNumberTextField(),
                    bankAccountsList(context),
                    // Obx(() => branchCodeTextField()),
                    const SizedBox(height: 20),

                    //  addNewBankBtn(),
                    // addAccountBtn(),
                    singup3Btn(),
                  ],
                ),
              ),
            ),
          ),
          const LoaderView()
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
            backgroundColor: const Color(0xffEBEFF3),
            progressColor: newColorBlue,
            center: Text(
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

  Widget bankAccountTitleTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: CustomTextField1(
        title: 'Account Title',
        hintText: 'Enter Account Title',
        controller: viewModel.bankAccTitleController,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return Validator.validateDefaultField(value,
              errorMessage: 'Bank Title is Required');
        },
        keyboardType: TextInputType.text,
      ),
    );
  }

  Widget accountNumberTextField() {
    return Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 25),
        child: CustomTextField1(
          keyboardType: TextInputType.number,
          title: 'Account Number',
          hintText: '0029 3103 1091 0553',
          onChanged: (value) {
            viewModel.bankAccNumberController.text = value;
          },
          autoValidateMode: AutovalidateMode.onUserInteraction,
          inputFormatters: [
            MaskedInputFormatter(
              "#### #### #### ####",
              allowedCharMatcher: RegExp(r'[0-9]+'),
            ),
          ],
          validator: (value) {
            return Validator.validateDefaultField(value,
                errorMessage: 'Acount Number is Required');
          },
        ));
  }

  Widget bankIBANNumberTextField() {
    return CustomTextField1(
      title: 'IBAN',
      hintText: 'PK51MEZN0003190106294217',
      controller: viewModel.bankIBANController,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return Validator.validateDefaultField(value,
            errorMessage: 'IBAN is required');
      },
      keyboardType: TextInputType.text,
    );
  }

  Widget addbanks() {
    return Align(
      alignment: Alignment.topLeft,
      child: Row(
        children: [
          const IconButton(
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
      child: CustomTextBtn(
        radius: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Submit',
              // style: newFontStyleSize14.copyWith(
              //     fontWeight: FontWeight.w500, color: kWhiteColor),kWhiteColor
            ),
            SizedBox(width: 4.h),
            const Icon(
              Icons.arrow_forward,
              size: 20,
            ),
          ],
        ),
        onPressed: () {
          viewModel.signUp3Btn();
          // Get.offNamed(Routes.dashboard);
          //
        },
      ),
    );
  }

  // Widget checkBoxTermCondition() {
  //   return Obx(
  //     () => Padding(
  //       padding: const EdgeInsets.only(bottom: 25, top: 5),
  //       child: CustomCheckBox2(
  //         value: viewModel.termAndCondition.value,
  //         onChanged: (value) {
  //           viewModel.termAndCondition.value = value;
  //         },
  //         text: Padding(
  //           padding: const EdgeInsets.only(top: 6),
  //           child: InkWell(
  //             onTap: () {
  //               // showTermsAndConditionDialog();
  //             },
  //             child: RichText(
  //               text: TextSpan(
  //                 style: newFontStyleSize14.copyWith(
  //                   color: newColorLightGrey2,
  //                 ),
  //                 children: [
  //                   const TextSpan(
  //                     text:
  //                         'By clicking ‘Create Account’, you’ve read and agreed to our ',
  //                   ),
  //                   TextSpan(
  //                     text: 'Terms and Conditions',
  //                     style: newFontStyleSize14.copyWith(
  //                       decoration: TextDecoration.underline,
  //                       color: newColorLightGrey2,
  //                     ),
  //                   ),
  //                   const TextSpan(
  //                     text:
  //                         ' and for my personal data to be processed according to',
  //                   ),
  //                   TextSpan(
  //                     text: ' ISMMART ',
  //                     style: newFontStyleSize14.copyWith(
  //                       color: newColorBlue2,
  //                       fontWeight: FontWeight.w700,
  //                     ),
  //                   ),
  //                   const TextSpan(text: 'Privacy Policy'),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  //
  // itemsBottomSheet() {
  //   showModalBottomSheet(
  //     context: Get.context!,
  //     isScrollControlled: true,
  //     backgroundColor: Colors.white,
  //     shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(20), topRight: Radius.circular(20))),
  //     constraints: BoxConstraints(maxHeight: Get.height * 0.9),
  //     builder: (BuildContext context) {
  //       return Stack(
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.fromLTRB(16, 10, 10, 3),
  //             child: Column(
  //               children: [
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     const Icon(
  //                       Icons.menu,
  //                       color: ThemeHelper.blue1,
  //                     ),
  //                     const SizedBox(width: 10),
  //                     const Text(
  //                       'Select Bank',
  //                       style: TextStyle(
  //                         fontWeight: FontWeight.w600,
  //                         color: ThemeHelper.blue1,
  //                         fontSize: 16,
  //                       ),
  //                     ),
  //                     const Spacer(),
  //                     IconButton(
  //                       onPressed: () {
  //                         Get.back();
  //                       },
  //                       icon: const Icon(
  //                         Icons.close,
  //                         color: Colors.red,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 const SizedBox(height: 10),
  //                 CustomTextField1(
  //                   hintText: 'Search Bank...',
  //                   controller: viewModel.searchController,
  //                   onChanged: (value) {
  //                     viewModel.onSearch(value);
  //                   },
  //                 ),
  //                 Obx(() => (viewModel.filteredBankList.isNotEmpty)
  //                         ? Expanded(
  //                             child: ListView.separated(
  //                               padding:
  //                                   const EdgeInsets.symmetric(vertical: 10),
  //                               itemCount: viewModel.filteredBankList.length,
  //                               itemBuilder: (context, index) {
  //                                 return InkWell(
  //                                   borderRadius: BorderRadius.circular(8),
  //                                   onTap: () {
  //                                     viewModel.bankController.text =
  //                                         viewModel.filteredBankList[index];
  //
  //                                     Get.back();
  //                                   },
  //                                   child: Padding(
  //                                     padding: const EdgeInsets.all(12),
  //                                     child: Text(
  //                                         viewModel.filteredBankList[index]),
  //                                   ),
  //                                 );
  //                               },
  //                               separatorBuilder: (context, index) {
  //                                 return const SizedBox(height: 3);
  //                               },
  //                             ),
  //                           )
  //                         : Expanded(
  //                             child: ListView.separated(
  //                               padding:
  //                                   const EdgeInsets.symmetric(vertical: 10),
  //                               itemCount: viewModel.allBankist.length,
  //                               itemBuilder: (context, index) {
  //                                 return InkWell(
  //                                   borderRadius: BorderRadius.circular(8),
  //                                   onTap: () {
  //                                     viewModel.bankController.text =
  //                                         viewModel.allBankist[index];
  //                                     Get.back();
  //                                   },
  //                                   child: Padding(
  //                                     padding: const EdgeInsets.all(12),
  //                                     child: Text(viewModel.allBankist[index]),
  //                                   ),
  //                                 );
  //                               },
  //                               separatorBuilder: (context, index) {
  //                                 return const SizedBox(height: 3);
  //                               },
  //                             ),
  //                           )
  //
  //                     // const Padding(
  //                     //         padding: EdgeInsets.only(top: 30),
  //                     //         child: Text('No Country Found'),
  //                     //       ),
  //                     )
  //               ],
  //             ),
  //           ),
  //           const LoaderView()
  //         ],
  //       );
  //     },
  //   );
  // }

  Widget addNewBankBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
      child: CustomTextBtn(
        height: 56,
        radius: 16,
        backgroundColor: ThemeHelper.grey3,
        foregroundColor: ThemeHelper.blue1,
        onPressed: () {
          Get.to(() => AddBankView(), arguments: {'editData': false});
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Add new bank',
              style: TextStyle(
                color: ThemeHelper.blue1,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: ThemeHelper.blue1,
            )
          ],
        ),
      ),
    );
  }
}
