import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismmart_vms/screens/store/store_viewmodel.dart';
import 'package:ismmart_vms/widgets/custom_text.dart';
import '../../helper/constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import 'bank_profile_viewmodel.dart';

class BankProfileView extends StatelessWidget {
  BankProfileView({super.key});

  final BankProfileViewModel viewModel = Get.put(BankProfileViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Form(
                    key: viewModel.signUpFormKey,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 30, left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          titleAndBackBtn(),
                          SizedBox(
                            height: 30,
                          ),
                          accountTitle(),
                          SizedBox(
                            height: 10,
                          ),
                          accountNumber_IBAN(),
                          SizedBox(
                            height: 10,
                          ),
                          bankTypeDrowpdown(),
                          // adressField(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
          const Align(
            alignment: Alignment.center,
            child: Text(
              'Bank Profile',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
          CustomBackButton(onTap: () {
            Get.back();
          }),
        ],
      ),
    );
  }

  Widget accountTitle() {
    return CustomTextField3(
      title: 'Account Title',
      hintText: 'Hasnain Mirrani',
      controller: viewModel.nameController,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      // validator: (value) {
      //   return Validator()
      //       .validateName(value, errorToPrompt: langKey.FirstNameReq.tr);
      // },
    );
  }

  Widget accountNumber_IBAN() {
    return CustomTextField3(
      title: 'Account Number / IBAN',
      hintText: '1234*********678',
      controller: viewModel.nameController,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      // validator: (value) {
      //   return Validator()
      //       .validateName(value, errorToPrompt: langKey.FirstNameReq.tr);
      // },
    );
  }

  Widget bankTypeDrowpdown() {
    return Obx(
      () => Column(children: [
        Align(
          alignment: Alignment.topLeft,
          child: CustomText(
            title: "Select Bank",
            size: 14,
            textAlign: TextAlign.start,
            style: GoogleFonts.dmSans(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: newColorDarkBlack2,
            ),
          ),
        ),
        Align(
            alignment: Alignment.topLeft, child: viewModel.bankTypeDrowpDown())
      ]),
    );
  }

  Widget adressField() {
    return CustomTextField3(
      title: 'Adress',
      hintText: 'My Stores Adress',
      controller: viewModel.nameController,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      // validator: (value) {
      //   return Validator()
      //       .validateName(value, errorToPrompt: langKey.FirstNameReq.tr);
      // },
    );
  }
}
