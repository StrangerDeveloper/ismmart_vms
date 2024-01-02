import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/constants.dart';
import 'package:ismmart_vms/helper/utils/size_utils.dart';
import 'package:ismmart_vms/widgets/image_layout_container.dart';
import 'package:ismmart_vms/widgets/loader_view.dart';
import 'package:ismmart_vms/widgets/custom_button.dart';
import 'package:ismmart_vms/widgets/custom_textfield.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../helper/global_variables.dart';
import '../../../../helper/theme_helper.dart';
import 'package:path/path.dart' as p;
import '../../../../helper/validator.dart';
import '../../../../widgets/custom_checkbox_list_tile.dart';
import '../../../../widgets/custom_loading.dart';
import 'sign_up_2_viewmodel.dart';

class SignUp2View extends StatelessWidget {
  SignUp2View({super.key});
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
                    SizedBox(height: 10.h),
                    Obx(
                      () => ImageLayoutContainer(
                          required: false,
                          title: 'Store Logo',
                          filePath: viewModel.shopLogoImage.value == ''
                              ? ''
                              : p.basename(viewModel.shopLogoImage.value),
                          onTap: () async {
                            await viewModel.selectImage(viewModel.shopLogoImage,
                                viewModel.shopImageErrorVisibility);
                          },
                          errorVisibility:
                              viewModel.shopImageErrorVisibility.value,
                          errorPrompt: 'Store Logo image is required'),
                    ),
                    storeSlug(),
                    storeType1(),
                    //   storeType(),
                    shopAddressField(),
                    // countryField(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: CustomTextField1(
                        title: 'Country',
                        hintText: 'Select one',
                        controller: viewModel.countryController,
                        isDropDown: true,
                        validator: (value) {
                          return Validator.validateDefaultField(value);
                        },
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
                        validator: (value) {
                          return Validator.validateDefaultField(value);
                        },
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
            backgroundColor: const Color(0xffEBEFF3),
            progressColor: newColorBlue,
            center: Text(
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
      validator: (value) {
        return Validator.validateDefaultField(value);
      },
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
        validator: (value) {
          return Validator.validateDefaultField(value);
        },
      ),
    );
  }

  Widget storeType1() {
    return InkWell(
      onTap: () {
        viewModel.getStoreTypes();
        itemsBottomSheet1();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Store Type',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
              color: ThemeHelper.grey3,
              border: Border.all(color: ThemeHelper.grey1, width: 1),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Obx(
              () => viewModel.storeTypeList
                      .where((element) => element.isSelected == true)
                      .isNotEmpty
                  ? Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: viewModel.storeTypeList
                          .map(
                            (e) => e.isSelected == true
                                ? Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 6),
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFFEFF5FB),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                    ),
                                    child: Text(
                                      e.name ?? '',
                                      style: const TextStyle(
                                        color: ThemeHelper.grey2,
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                          )
                          .toList(),
                    )
                  : const Padding(
                      padding: EdgeInsets.only(left: 2, top: 5, bottom: 5),
                      child: Text(
                        'Home Decor',
                        style: TextStyle(
                          color: ThemeHelper.grey2,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
  //
  // Widget storeType() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 1),
  //     child: CustomTextField1(
  //       controller: viewModel.storeTypeController,
  //       title: 'Store Type',
  //       hintText: 'Select Store Type',
  //       isDropDown: true,
  //       onTap: () {
  //         viewModel.getStoreTypes();
  //         CustomBottomSheet1(
  //           selectedIndex: viewModel.storeTypeSelectedIndex.value,
  //           list: viewModel.typeList,
  //           onChanged: (value) {
  //             viewModel.storeTypeSelectedIndex.value = value;
  //             viewModel.storeTypeController.text = viewModel.typeList[value];
  //             viewModel.storeTypeSelectedId.value =
  //                 viewModel.storeTypeIdList[value];
  //           },
  //         ).show();
  //       },
  //     ),
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
        validator: (value) {
          return Validator.validateDefaultField(value);
        },
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
        () => GlobalVariable.showLoader.value == true
            ? const CustomLoading(isItBtn: true)
            : CustomTextBtn(
                radius: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Next",
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
                  viewModel.signUpStep2();
                  // Get.offNamed(Routes.dashboard);
                  //
                },
              ),
      ),
    );
  }

  itemsBottomSheet1() {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      constraints: BoxConstraints(maxHeight: Get.height * 0.7),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 10, 3),
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
                    'Store Type',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: ThemeHelper.blue1,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  Obx(
                    () => CustomTextBtn(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Get.theme.primaryColor,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      radius: 4,
                      width: 100,
                      child: Text(viewModel.selectAllValue.value
                          ? 'Unselect'
                          : 'Select All'),
                      onPressed: () {
                        viewModel.selectAllItems();
                      },
                    ),
                  ),
                ],
              ),
              const Divider(),
              Expanded(
                child: Obx(
                  () => viewModel.storeTypeList.isNotEmpty
                      ? ListView.builder(
                          itemCount: viewModel.storeTypeList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Obx(
                              () => CheckBoxListTile1(
                                title:
                                    viewModel.storeTypeList[index].name ?? '',
                                value:
                                    viewModel.storeTypeList[index].isSelected ??
                                        false,
                                isSelected:
                                    viewModel.storeTypeList[index].isSelected ??
                                        false,
                                onChanged: (value) {
                                  viewModel.selectSingleItem(value, index);
                                },
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Text('No Data Found'),
                        ),
                ),
              ),
              const Divider(height: 0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomTextBtn(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Get.theme.primaryColor,
                      radius: 4,
                      child: const Text('Cancel'),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                  Expanded(
                    child: CustomTextBtn(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Get.theme.primaryColor,
                      radius: 4,
                      child: const Text(
                        'Done',
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
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
          child: Stack(
            children: [
              Column(
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                itemCount: viewModel.filteredCountryList.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    borderRadius: BorderRadius.circular(8),
                                    onTap: () {
                                      viewModel.countryController.text =
                                          viewModel.filteredCountryList[index];
                                      viewModel.getCountryId(
                                          viewModel.countryController.text);
                                      GlobalVariable.showLoader.value == false;

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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                itemCount: viewModel.allCountryList.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    borderRadius: BorderRadius.circular(8),
                                    onTap: () {
                                      viewModel.countryController.text =
                                          viewModel.allCountryList[index];
                                      GlobalVariable.showLoader.value = false;
                                      Get.back();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child:
                                          Text(viewModel.allCountryList[index]),
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
              viewModel.allCountryList.length <= 0 ? LoaderView() : SizedBox()
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
                  viewModel.onSearchCity(value);
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
                                  viewModel.cityController.text =
                                      viewModel.filteredCityList[index];
                                  viewModel
                                      .getCityId(viewModel.cityController.text);
                                  GlobalVariable.showLoader.value = false;
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
                            itemCount: viewModel.filteredCityList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () {
                                  viewModel.cityController.text =
                                      viewModel.filteredCityList[index];
                                  GlobalVariable.showLoader.value = false;
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
