import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismmart_vms/screens/add_bank/add_bank_viewmodel.dart';

import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/loader_view.dart';

class AddBankView extends StatelessWidget {
  AddBankView({super.key});

  final AddBankViewModel viewModel = Get.put(AddBankViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar2(
        title: viewModel.isEdit ? 'Edit Bank Details' : 'Add Bank Details',
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: viewModel.addBankFormKey,
              child: Column(
                children: [
                  creditCard(),
                  accountTitleTxtField(),
                  accountNumberTxtField(),
                  bankNameTxtField(),
                  Padding(
                    padding: const EdgeInsets.only(top: 18, bottom: 5),
                    child: CustomTextBtn(
                      title: viewModel.isEdit ? 'Update' : 'Save & Create',
                      onPressed: () {
                        // viewModel.saveAndCreateBtn();
                      },
                    ),
                  ),
                  CustomTextBtn(
                    title: 'Discard',
                    backgroundColor: Colors.black,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ],
              ),
            ),
          ),
          const LoaderView(),
        ],
      ),
    );
  }

  Widget creditCard() {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 16, 15, 20),
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 30),
      height: Get.height * 0.23,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff02251F).withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ],
        gradient: const LinearGradient(
          begin: Alignment(0.96, -0.28),
          end: Alignment(-0.96, 0.28),
          colors: [
            Color(0xFF632400),
            Color(0xFF064A7D),
          ],
        ),
        image: const DecorationImage(
          alignment: Alignment.centerLeft,
          image: AssetImage('assets/images/card_layer.png'),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => Expanded(
                  child: Text(
                    viewModel.bankName.value,
                    maxLines: 1,
                    style: GoogleFonts.ubuntu(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
              SvgPicture.asset('assets/images/master_card.svg'),
            ],
          ),
          const Spacer(),
          Obx(
            () => Text(
              viewModel.cardHolder.value,
              maxLines: 1,
              style: GoogleFonts.ibmPlexMono(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 3),
          Obx(
            () => Text(
              viewModel.cardNumber.value,
              maxLines: 1,
              style: GoogleFonts.ibmPlexMono(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget accountTitleTxtField() {
    return CustomTextField1(
      title: 'Account Title',
      hintText: 'Ashar Atique',
      onChanged: (value) {
        viewModel.cardHolder.value = value;
        if (value.isEmpty) {
          viewModel.cardHolder.value = 'Card Holder';
        }
      },
    );
  }

  Widget accountNumberTxtField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: CustomTextField1(
        title: 'Account Number',
        hintText: 'PKMEZN00293103109103',
        onChanged: (value) {
          viewModel.cardNumber.value = value;
          if (value.isEmpty) {
            viewModel.cardNumber.value = '0000 0000 0000 0000';
          }
        },
        inputFormatters: [
          MaskedInputFormatter(
            "#### #### #### ####",
            allowedCharMatcher: RegExp(r'[0-9]+'),
          ),
        ],
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget bankNameTxtField() {
    return CustomTextField1(
      // controller: viewModel.nameController,
      title: 'Bank Name',
      hintText: 'Meezan Bank',
      onChanged: (value) {
        viewModel.bankName.value = value;
        if (value.isEmpty) {
          viewModel.bankName.value = 'Meezan Bank';
        }
      },
    );
  }
}
