
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/screens/store/store_viewmodel.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../helper/constants.dart';
import '../../helper/global_variables.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_loading.dart';
import '../../widgets/custom_textfield.dart';

class StoreView extends StatelessWidget {
  StoreView({Key? key}) : super(key: key);
  final StoreViewModel viewModel = Get.put(StoreViewModel());

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
                padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleAndBackBtn(),
                    const Divider(
                      color: Color(0xffEEEEEE),
                      thickness: 1,
                      height: 20,
                    ),

                    Obx(
                          () => Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30.0, bottom: 30),
                          child: Stack(
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(
                                  viewModel.shopLogoImage.value == ''
                                      ? 'assets/icons/image 9.png'
                                      : viewModel.shopLogoImage.value,
                                ),
                                backgroundColor: Colors.transparent,
                                radius: 70,
                              ),
                              Positioned(
                                  top: 100,
                                  left: 100,
                                  child: GestureDetector(
                                    onTap: () async {
                                      await viewModel.selectImage(
                                          viewModel.shopLogoImage,
                                          viewModel.shopImageErrorVisibility);
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      child: Center(
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.camera_alt_outlined),
                                          color: Colors.white,
                                          iconSize: 13,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white),
                                        color: newColorBlue,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                    shopNameField(),
                    // shopCategoryField(),
                    // shopDescriptionTextField(),
                    // ntnTextField(),
                    // shopPhoneNoTextField(),
                    // ownerCNICField(),
                    // countryPicker(),
                    // cityPicker(),
                    SizedBox(
                      height: 10,
                    ),
                    storeSlug(),
                    storeType(),
                    countryField(),
                    cityField(),
                    shopAddressField(),

                    customBtn(),
                    customBtn2(),
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
    return SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              'Edit Store',
              style: newFontStyleSize20DM,
            ),
          ),
          CustomBackButton(onTap: () {
            Get.back();
          }),
        ],
      ),
    );
  }

  Widget createAVendorAccount() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
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
      padding: const EdgeInsets.only(bottom: 30),
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
                        text: 'Banking Information',
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
            percent: 0.5,
            backgroundColor: Color(0xffEBEFF3),
            progressColor: newColorBlue,
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
    return CustomTextField1(
      prefixIcon: Icons.store,
      keyboardType: TextInputType.text,
      title: 'Store Name',
      hintText: 'ISMMART',
      controller: viewModel.storeNameController,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      // validator: (value) {
      //   return Validator().validateName(value, errorToPrompt: langKey.storeNameReq.tr);
      // },
    );
  }

  Widget storeSlug() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 25),
      child: CustomTextField1(
        keyboardType: TextInputType.text,
        title: 'Store Slug',
        hintText: 'ismmartshop',
        controller: viewModel.storeNameController,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        // validator: (value) {
        //   return Validator().validateName(value, errorToPrompt: langKey.storeNameReq.tr);
        // },
      ),
    );
  }

  Widget storeType() {
    return CustomTextField1(
      isDropDown: true,
      keyboardType: TextInputType.text,
      title: 'Store Type',
      hintText: 'Home Decor',
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
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: CustomTextField1(
        keyboardType: TextInputType.text,
        title: 'Address',
        hintText: 'Shop#748, Saddar Bazar, Rawalpindi',
        controller: viewModel.storeAddressController,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        // validator: (value) {
        //   return Validator().validateAddress(value);
        // },
      ),
    );
  }

  Widget countryField() {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: CustomTextField1(
        isDropDown: true,
        keyboardType: TextInputType.text,
        title: 'Country',
        hintText: 'Select one',
        controller: viewModel.storeAddressController,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        // validator: (value) {
        //   return Validator().validateAddress(value);
        // },
      ),
    );
  }

  Widget cityField() {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: CustomTextField1(
        isDropDown: true,
        keyboardType: TextInputType.text,
        title: 'City',
        hintText: 'Select one',
        controller: viewModel.storeAddressController,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        // validator: (value) {
        //   return Validator().validateAddress(value);
        // },
      ),
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
  Widget customBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Obx(
            () => GlobalVariable.showLoader.value
            ? const CustomLoading(isItBtn: true)
            : CustomRoundedTextBtn(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Save & Update',
                  style: newFontStyleSize14.copyWith(
                      fontWeight: FontWeight.w500, color: kWhiteColor),
                ),
              ],
            ),
            onPressed: () {
              // Get.off(StoresView());
            }),
      ),
    );
  }

  Widget customBtn2() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 40),
      child: Obx(
            () => GlobalVariable.showLoader.value
            ? const CustomLoading(isItBtn: true)
            : CustomRoundedTextBtn(
            backgroundColor: newColorDarkBlack,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Discard',
                  style: newFontStyleSize14.copyWith(
                      fontWeight: FontWeight.w500, color: kWhiteColor),
                ),
              ],
            ),
            onPressed: () {
              // Get.off(StoresView());
            }),
      ),
    );
  }
}


