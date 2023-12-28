import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/constants.dart';
import 'package:ismmart_vms/widgets/image_layout_container.dart';
import 'package:path/path.dart';
import 'package:ismmart_vms/widgets/custom_button.dart';
import 'package:ismmart_vms/widgets/custom_textfield.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../helper/global_variables.dart';
import '../../../../helper/theme_helper.dart';
import '../../../../widgets/custom_bottom_sheet.dart';
import '../../../../widgets/custom_loading.dart';
import 'sign_up_2_viewmodel.dart';

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
                    const Divider(
                      color: Color(0xffEEEEEE),
                      thickness: 1,
                      height: 20,
                    ),
                    createAVendorAccount(),
                    progress(),
                    shopNameField(),
                    SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () => ImageLayoutContainer(
                          required: false,
                          title: 'Store Logo',
                          filePath: viewModel.shopLogoImage.value == ''
                              ? ''
                              : basename(viewModel.shopLogoImage.value),
                          onTap: () async {
                            await viewModel.selectImage(viewModel.shopLogoImage,
                                viewModel.shopImageErrorVisibility);
                          },
                          errorVisibility:
                              viewModel.shopImageErrorVisibility.value,
                          errorPrompt: 'Store Logo image is required'),
                    ),
                    storeSlug(),
                    storeType(),
                    shopAddressField(),
                    // countryField(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: CustomTextField1(
                        title: 'Country',
                        hintText: 'Select one',
                        controller: viewModel.countryController,
                        isDropDown: true,
                        onTap: () {
                          viewModel.resetValue();
                          viewModel.getCountryList();
                          itemsBottomSheet();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: CustomTextField1(
                        title: 'City',
                        hintText: 'Select one',
                        controller: viewModel.cityController,
                        isDropDown: true,
                        onTap: () {
                          viewModel.resetValueCity();
                          // viewModel.getCityList();
                          itemsBottomSheetForCity();
                        },
                      ),
                    ),
                    singup2Btn(),
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
      hintText: 'Al-Jannat',
      controller: viewModel.storeNameController,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      // validator: (value) {
      //   return Validator().validateName(value, errorToPrompt: langKey.storeNameReq.tr);
      // },
    );
  }

  Widget storeSlug() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 25),
      child: CustomTextField1(
        keyboardType: TextInputType.text,
        title: 'Store Slug (non repeatable)',
        hintText: 'Al-Jannat Shopping Mall',
        controller: viewModel.storeSlugController,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        // validator: (value) {
        //   return Validator().validateName(value, errorToPrompt: langKey.storeNameReq.tr);
        // },
      ),
    );
  }

  Widget storeType() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: CustomTextField1(
        controller: viewModel.storeTypeController,
        title: 'Store Type',
        hintText: 'Select Store Type',
        isDropDown: true,
        onTap: () {
          viewModel.geStoreTypeList();
          CustomBottomSheet1(
            selectedIndex: viewModel.storeTypeSelectedIndex.value,
            list: viewModel.typeList,
            onChanged: (value) {
              viewModel.storeTypeSelectedIndex.value = value;
              viewModel.storeTypeController.text = viewModel.typeList[value];
              viewModel.storeTypeSelectedId.value =
                  viewModel.storeTypeIdList[value];
            },
          ).show();
        },
      ),
    );
  }

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

  Widget singup2Btn() {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Obx(
        () => GlobalVariable.showLoader.value
            ? const CustomLoading(isItBtn: true)
            : CustomRoundedTextBtn(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Next',
                      style: newFontStyleSize14.copyWith(
                          fontWeight: FontWeight.w500, color: kWhiteColor),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Icon(
                      Icons.arrow_forward,
                      size: 20,
                    ),
                  ],
                ),
                onPressed: () {
                  viewModel.signUpStep2();
                  //Get.to(SignUp3View());
                },
              ),
      ),
    );
  }

  itemsBottomSheet() {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      constraints: BoxConstraints(maxHeight: Get.height * 0.9),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 10, 3),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.menu,
                    color: ThemeHelper.blue1,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Select Country',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: ThemeHelper.blue1,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              CustomTextField1(
                hintText: 'Search Country...',
                controller: viewModel.searchController,
                onChanged: (value) {
                  viewModel.onSearch(value);
                },
              ),
              Obx(() => (viewModel.filteredCountryList.isNotEmpty)
                      ? Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            itemCount: viewModel.filteredCountryList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () {
                                  viewModel.countryController.text =
                                      viewModel.filteredCountryList[index];
                                  viewModel.getCountryId(
                                      viewModel.countryController.text);

                                  Get.back();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Text(
                                      viewModel.filteredCountryList[index]),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 3);
                            },
                          ),
                        )
                      : Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            itemCount: viewModel.allCountryList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () {
                                  viewModel.countryController.text =
                                      viewModel.allCountryList[index];
                                  Get.back();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Text(viewModel.allCountryList[index]),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 3);
                            },
                          ),
                        )

                  // const Padding(
                  //         padding: EdgeInsets.only(top: 30),
                  //         child: Text('No Country Found'),
                  //       ),
                  )
            ],
          ),
        );
      },
    );
  }

  //----------Bottom Sheet for City----------
  itemsBottomSheetForCity() {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      constraints: BoxConstraints(maxHeight: Get.height * 0.9),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 10, 3),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.menu,
                    color: ThemeHelper.blue1,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Select City',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: ThemeHelper.blue1,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              CustomTextField1(
                hintText: 'Search City...',
                controller: viewModel.citySearchController,
                onChanged: (value) {
                  viewModel.onSearch(value);
                },
              ),
              Obx(() => (viewModel.filteredCityList.isNotEmpty)
                      ? Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            itemCount: viewModel.filteredCityList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () {
                                  viewModel.getCityId(index);
                                  viewModel.cityController.text =
                                      viewModel.filteredCityList[index];
                                  var i = viewModel.cityIdList[index];
                                  print(i);

                                  Get.back();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child:
                                      Text(viewModel.filteredCityList[index]),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 3);
                            },
                          ),
                        )
                      : Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            itemCount: viewModel.allCityList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () {
                                  viewModel.cityController.text =
                                      viewModel.allCityList[index];
                                  Get.back();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Text(viewModel.allCityList[index]),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 3);
                            },
                          ),
                        )

                  // const Padding(
                  //         padding: EdgeInsets.only(top: 30),
                  //         child: Text('No Country Found'),
                  //       ),
                  )
            ],
          ),
        );
      },
    );
  }
}
