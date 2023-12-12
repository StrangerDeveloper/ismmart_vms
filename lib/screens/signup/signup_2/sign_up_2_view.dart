import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismmart_vms/screens/signup/signup_2/sign_up_2_viewmodel.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:path/path.dart';
import '../../../helper/constants.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/image_layout_container.dart';

class SignUp2View extends StatelessWidget {
  SignUp2View({Key? key}) : super(key: key);
  final SignUp2ViewModel viewModel = Get.put(SignUp2ViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              key: viewModel.vendorSignUp2FormKey,
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleAndBackBtn(),
                    // createAVendorAccount(),
                    progress(),
                    shopNameField(),
                    // shopCategoryField(),
                    // shopDescriptionTextField(),
                    // ntnTextField(),
                    // shopPhoneNoTextField(),
                    // ownerCNICField(),
                    // countryPicker(),
                    // cityPicker(),
                    Obx(() => ImageLayoutContainer(
                        title: 'Store Logo',
                        filePath: viewModel.shopLogoImage.value == '' ? '' : basename(viewModel.shopLogoImage.value),
                        onTap: () async{
                          await viewModel.selectImage(viewModel.shopLogoImage, viewModel.shopImageErrorVisibility);
                        },
                        errorVisibility: viewModel.shopImageErrorVisibility.value,
                        errorPrompt: 'Store Logo image is required'
                    ),
                    ),
                    shopAddressField(),
                    submitBtn(),
                  ],
                ),
              ),
            ),
          ),
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
  //             text: 'Add',
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
                  'Vendor Account Progress',
                  style: newFontStyle1.copyWith(
                    color: newColorBlue2,
                  ),
                ),
                SizedBox(height: 6),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Next Step: ',
                        style: newFontStyle1.copyWith(
                          fontSize: 12,
                          color: newColorBlue4,
                        ),
                      ),
                      TextSpan(
                        text: 'Bank Details',
                        style: newFontStyle1.copyWith(
                          fontSize: 12,
                          color: newColorBlue3,
                        ),
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
            percent: 0.5,
            backgroundColor: Color(0xffEBEFF3),
            progressColor: Color(0xff0CBC8B),
            center: new Text(
              "2 of 3",
              style: poppinsH2.copyWith(
                color: newColorBlue2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget shopNameField() {
    return CustomTextField3(
      keyboardType: TextInputType.text,
      title: 'Store Name',
      hintText: 'Enter Store Name',
      controller: viewModel.storeNameController,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      // validator: (value) {
      //   return Validator().validateName(value, errorToPrompt: langKey.storeNameReq.tr);
      // },
    );
  }

  // Widget shopCategoryField() {
  //   return Obx(
  //         () =>
  //         Padding(
  //           padding: const EdgeInsets.symmetric(vertical: 20.0),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Padding(
  //                 padding: const EdgeInsets.only(bottom: 3),
  //                 child: RichText(
  //                   text: TextSpan(
  //                       text: 'Store Type',
  //                       style: GoogleFonts.dmSans(
  //                         fontSize: 14,
  //                         fontWeight: FontWeight.w700,
  //                         color: newColorDarkBlack2,
  //                       ),
  //                       children: [
  //                         TextSpan(
  //                           text: '*',
  //                           style: TextStyle(color: Colors.red),
  //                         )
  //                       ]
  //                   ),
  //                 ),
  //               ),
  //               DropdownSearch<CategoryModel>(
  //                 popupProps: PopupProps.dialog(
  //                   showSearchBox: true,
  //                   dialogProps: DialogProps(
  //                     shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(10),
  //                     ),
  //                   ),
  //                   searchDelay: const Duration(milliseconds: 0),
  //                   searchFieldProps: AppConstant.searchFieldProp(),
  //                 ),
  //                 items: viewModel.categoriesList,
  //                 itemAsString: (model) => model.name ?? "",
  //                 dropdownDecoratorProps: DropDownDecoratorProps(
  //                   baseStyle: newFontStyle0.copyWith(
  //                     color: newColorDarkBlack2,
  //                     fontSize: 15,
  //                   ),
  //                   dropdownSearchDecoration: InputDecoration(
  //                     contentPadding: EdgeInsets.only(top: 13.5),
  //                     suffixIconColor: Color(0xffADBCCB),
  //                     isDense: true,
  //                     hintText: 'Choose Store Type',
  //                     hintStyle: TextStyle(color: Colors.black),
  //                     enabledBorder: UnderlineInputBorder(
  //                       borderSide: BorderSide(color: Color(0xffEEEEEE)),
  //                     ),
  //                     focusedBorder: UnderlineInputBorder(
  //                       borderSide: BorderSide(color: Color(0xff929AAB)),
  //                     ),
  //                   ),
  //                 ),
  //                 onChanged: (CategoryModel? newValue) {
  //                   viewModel.selectedCategory.value = newValue!;
  //                   viewModel.shopCategoryId.value = newValue.id!.toInt();
  //                   viewModel.categoryErrorVisibility.value = false;
  //                 },
  //                 selectedItem: viewModel.selectedCategory.value,
  //               ),
  //               Visibility(
  //                 visible: viewModel.categoryErrorVisibility.value,
  //                 child: Text(
  //                   langKey.categoryReq.tr,
  //                   style: GoogleFonts.dmSans(
  //                     color: Colors.red.shade700,
  //                   ),
  //                 ),
  //               )
  //             ],
  //           ),
  //         ),
  //   );
  // }

  Widget shopAddressField() {
    return CustomTextField3(
      keyboardType: TextInputType.text,
      title: 'Store Address',
      hintText: 'Enter Store Address',
      controller: viewModel.storeAddressController,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      // validator: (value) {
      //   return Validator().validateAddress(value);
      // },
    );
  }

  // Widget countryPicker() {
  //   return Obx(
  //     () => Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.only(bottom: 3),
  //           child: RichText(
  //             text: TextSpan(
  //               text: 'Country',
  //               style: GoogleFonts.dmSans(
  //                 fontSize: 14,
  //                 fontWeight: FontWeight.w700,
  //                 color: newColorDarkBlack2,
  //               ),
  //               children: [
  //                 TextSpan(
  //                   text: ' *',
  //                   style: TextStyle(color: Colors.red),
  //                 )
  //               ],
  //             ),
  //           ),
  //         ),
  //         DropdownSearch<CountryModel>(
  //           popupProps: PopupProps.dialog(
  //             showSearchBox: true,
  //             dialogProps: DialogProps(
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(10),
  //               ),
  //             ),
  //             searchFieldProps: AppConstant.searchFieldProp(),
  //           ),
  //           items: cityViewModel.authController.countries,
  //           itemAsString: (model) => model.name ?? "",
  //           dropdownDecoratorProps: DropDownDecoratorProps(
  //             baseStyle: newFontStyle0.copyWith(
  //               color: newColorDarkBlack2,
  //               fontSize: 15,
  //             ),
  //             dropdownSearchDecoration: InputDecoration(
  //               contentPadding: EdgeInsets.only(top: 13.5),
  //               suffixIconColor: Color(0xffADBCCB),
  //               isDense: true,
  //               hintText: langKey.chooseCountry.tr,
  //               hintStyle: TextStyle(color: Colors.black),
  //               enabledBorder: UnderlineInputBorder(
  //                 borderSide: BorderSide(color: Color(0xffEEEEEE)),
  //               ),
  //               focusedBorder: UnderlineInputBorder(
  //                 borderSide: BorderSide(color: Color(0xff929AAB)),
  //               ),
  //             ),
  //           ),
  //           onChanged: (CountryModel? newValue) {
  //             cityViewModel.setSelectedCountry(newValue!);
  //             viewModel.countryID.value = newValue.id!;
  //             viewModel.cityID.value = 0;
  //             cityViewModel.selectedCity.value = CountryModel();
  //             cityViewModel.cityId.value = 0;
  //             cityViewModel.authController.selectedCity.value = CountryModel();
  //
  //
  //             viewModel.countryErrorVisibility.value = false;
  //           },
  //           selectedItem: authController.newAcc.value == true
  //               ? cityViewModel.selectedCountry.value
  //               : cityViewModel.authController.selectedCountry.value,
  //         ),
  //         Visibility(
  //           visible: viewModel.countryErrorVisibility.value,
  //           child: Text(
  //             langKey.countryReq.tr,
  //             style: GoogleFonts.dmSans(
  //               color: Colors.red.shade700,
  //             ),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget cityPicker() {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(vertical: 20),
  //     child: Obx(
  //       () => authController.cities.isEmpty
  //           ? Container()
  //           : authController.isLoading.isTrue
  //               ? CustomLoading(
  //                   isItForWidget: true,
  //                   color: kPrimaryColor,
  //                 )
  //               : Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Padding(
  //                       padding: const EdgeInsets.only(bottom: 3),
  //                       child: RichText(
  //                         text: TextSpan(
  //                           text: langKey.storeCity.tr,
  //                           style: GoogleFonts.dmSans(
  //                             fontSize: 14,
  //                             fontWeight: FontWeight.w700,
  //                             color: newColorDarkBlack2,
  //                           ),
  //                           children: [
  //                             TextSpan(
  //                               text: ' *',
  //                               style: TextStyle(color: Colors.red),
  //                             )
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                     DropdownSearch<CountryModel>(
  //                       popupProps: PopupProps.dialog(
  //                         showSearchBox: true,
  //                         dialogProps: DialogProps(
  //                           shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(10),
  //                           ),
  //                         ),
  //                         searchFieldProps: AppConstant.searchFieldProp(),
  //                       ),
  //                       items: cityViewModel.authController.cities,
  //                       itemAsString: (model) => model.name ?? "",
  //                       dropdownDecoratorProps: DropDownDecoratorProps(
  //                         baseStyle: newFontStyle0.copyWith(
  //                           color: newColorDarkBlack2,
  //                           fontSize: 15,
  //                         ),
  //                         dropdownSearchDecoration: InputDecoration(
  //                           contentPadding: EdgeInsets.only(top: 13.5),
  //                           suffixIconColor: Color(0xffADBCCB),
  //                           isDense: true,
  //                           hintText: langKey.chooseCountry.tr,
  //                           enabledBorder: UnderlineInputBorder(
  //                             borderSide: BorderSide(color: Color(0xffEEEEEE)),
  //                           ),
  //                           focusedBorder: UnderlineInputBorder(
  //                             borderSide: BorderSide(color: Color(0xff929AAB)),
  //                           ),
  //                         ),
  //                       ),
  //                       onChanged: (CountryModel? newValue) {
  //                         cityViewModel.selectedcity.value =
  //                             newValue!.name ?? "";
  //                         cityViewModel.setSelectedCity(newValue);
  //                         viewModel.cityID.value = newValue.id!;
  //                         viewModel.cityErrorVisibility.value = false;
  //                       },
  //                       selectedItem: authController.newAcc.value == true
  //                           ? cityViewModel.selectedCity.value
  //                           : cityViewModel.authController.selectedCity.value,
  //                     ),
  //                     Visibility(
  //                       visible: viewModel.cityErrorVisibility.value,
  //                       child: Text(
  //                         langKey.cityReq.tr,
  //                         style: GoogleFonts.dmSans(
  //                           color: Colors.red.shade700,
  //                         ),
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //     ),
  //   );
  // }

  Widget submitBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 25),
      child: CustomRoundedTextBtn(
                title: 'Proceed',
                onPressed: () async{
                  await viewModel.proceed();
                  // Get.to(() => VendorSignUp3View());
                },
              ),
      );
  }
}