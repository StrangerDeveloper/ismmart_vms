import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/screens/add_product/add_product_3/add_product_3_viewmodel.dart';
import 'package:ismmart_vms/widgets/custom_button.dart';
import 'package:ismmart_vms/widgets/loader_view.dart';

import '../../../helper/constants.dart';
import '../../../helper/theme_helper.dart';
import '../../../widgets/custom_bottom_sheet.dart';
import '../../../widgets/custom_checkbox.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/stepperText.dart';

class AddProduct3View extends StatelessWidget {
  AddProduct3View({super.key});

  final AddProduct3ViewModel viewModel = Get.put(AddProduct3ViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(child: stepperText(3)),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  padding: const EdgeInsets.only(
                      left: 12, top: 12, right: 12, bottom: 5),
                  decoration: const BoxDecoration(
                    color: ThemeHelper.grey3,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Shipping',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // checkBox('This is a physical product', viewModel.checkBoxIsPhysicalProduct),
                      // weightTxtField(),
                      // dimensionsSection(),
                      // const Divider(),
                      countryRegionTxtField(),
                      hsCodeTxtField(),
                      checkBox('Continue selling when out-of-stock', viewModel.checkBoxContinueSelling),
                    ],
                  ),
                ),
                // searchEngineListing(),
                productStatus(),
                const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 15),
                  child: Text(
                    'Publishing',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Text(
                  'Sales Channels',
                  style: TextStyle(
                    color: ThemeHelper.grey4,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 5),
                onlineStoreCheckBox(),
                fbAndInstagramCheckBox(),
                const Padding(
                  padding: EdgeInsets.only(top: 6, bottom: 3),
                  child: Text(
                    'Markets',
                    style: TextStyle(
                      color: ThemeHelper.grey4,
                      fontSize: 12,
                    ),
                  ),
                ),
                europeInternationalCheckBox(),
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 5),
                  child: CustomTextBtn(
                    title: 'Save',
                    onPressed: () {
                      viewModel.addProduct();
                    },
                  ),
                ),
                CustomTextBtn(
                  title: 'Back',
                  backgroundColor: Colors.black,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          const LoaderView()
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 22,
          color: newColorLightGrey2,
        ),
      ),
      title: Text(
          viewModel.editProduct.value ? 'Edit Product' : 'Add Product'
      ),
    );
  }

  Widget checkBox(text, RxBool checkValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Obx(() => AnimatedContainer(
            height: 20,
            width: 20,
            margin: const EdgeInsets.only(right: 8),
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
                color: checkValue.value ? newColorBlue : Colors.white,
                borderRadius: BorderRadius.circular(7),
                border: Border.all(
                  color: checkValue.value ? newColorBlue : newColorLightGrey2,
                )
            ),
            child: InkWell(
                onTap: () {
                  checkValue.value = !checkValue.value;
                },
                child: checkValue.value ? const Center(
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 15,
                  ),
                ) : const SizedBox()
            ),
          ),
          ),
          Text(
            text,
            style: interNormalText.copyWith(
                color: newColorLightGrey2,
                fontWeight: FontWeight.w400,
                fontSize: 11
            ),
          )
        ],
      ),
    );
  }

  Widget countryRegionTxtField() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 15),
      child: CustomTextField5(
        title: 'Country/Region of origin',
        hintText: 'Select Country',
        suffixIcon: Icons.unfold_more,
        controller: viewModel.countryController,
        readOnly: true,
        onTap: () {
          CustomBottomSheet2(
            selectedIndex: viewModel.countrySelected.value,
            list: viewModel.countryList,
            onChanged: (value) {
              viewModel.countrySelected.value = value;
              viewModel.countryController.text = viewModel.countryList[value].name!;
            },
          ).show();
        },
      ),
    );
  }

  Widget hsCodeTxtField() {
    return CustomTextField5(
      title: 'Harmonized System (HS) code',
      hintText: 'Search by product keyword or code',
      controller: viewModel.hsCodeController,
    );
  }

  Widget continueSellingOFS() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: CustomCheckBox(
        value: viewModel.checkBoxIsPhysicalProduct,
        onChanged: (value) {
          viewModel.checkBoxIsPhysicalProduct.value = value;
        },
        child: const Text(
          'Continue selling when out of stock',
          style: TextStyle(
            color: ThemeHelper.grey2,
            fontSize: 10,
          ),
        ),
      ),
    );
  }

  Widget searchEngineListing() {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      decoration: const BoxDecoration(
        color: ThemeHelper.grey3,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  'Search engine listing',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              CustomTextBtn(
                  backgroundColor: Colors.transparent,
                  foregroundColor: ThemeHelper.blue1,
                  width: 80,
                  onPressed: () {},
                  child: const Text(
                    'Edit',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(left: 12, right: 12, bottom: 12),
            child: Text(
              'Add a title and description to see how this collection might appear in a search engine listing',
              style: TextStyle(
                color: ThemeHelper.grey4,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget productStatus() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 3, top: 12, bottom: 7),
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      decoration: const BoxDecoration(
        color: ThemeHelper.grey3,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              'Product Status',
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Obx(() => Transform.scale(
                  scale: 0.8,
                  child: CupertinoSwitch(
                    activeColor: newColorBlue5,
                    value: viewModel.productActiveStatusSwitch.value,
                    onChanged: (value) {
                      viewModel.productActiveStatusSwitch.value = value;
                    },
                  ),
                ),
              ),
              const Text(
                'Set Active',
                style: TextStyle(
                  color: ThemeHelper.blue1,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget onlineStoreCheckBox() {
    return CustomCheckBox(
      value: viewModel.checkBoxOnlineStore,
      onChanged: (value) {
        viewModel.checkBoxOnlineStore.value = value;
      },
      child: const Text(
        'Online Store',
        style: TextStyle(
          color: ThemeHelper.grey2,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget fbAndInstagramCheckBox() {
    return CustomCheckBox(
      value: viewModel.checkBoxFbAndInstagram,
      onChanged: (value) {
        viewModel.checkBoxFbAndInstagram.value = value;
      },
      child: const Text(
        'Facebook & Instagram',
        style: TextStyle(
          color: ThemeHelper.grey2,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget europeInternationalCheckBox() {
    return CustomCheckBox(
      value: viewModel.checkBoxEuropeInternational,
      onChanged: (value) {
        viewModel.checkBoxEuropeInternational.value = value;
      },
      child: const Text(
        'Europe, International, and Pakistan',
        style: TextStyle(
          color: ThemeHelper.grey2,
          fontSize: 12,
        ),
      ),
    );
  }
}
