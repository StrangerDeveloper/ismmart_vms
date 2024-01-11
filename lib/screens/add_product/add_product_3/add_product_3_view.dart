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
                      checkBox('This is a physical product', viewModel.checkBoxIsPhysicalProduct),
                      weightTxtField(),
                      // dimensionsSection(),
                      const Divider(),
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
      title: const Text('Add Product'),
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

  Widget dimensionTxtField({
    required String inputFieldTitle,
    required String inputFieldHintText,
    required String unitFieldHintText,
    required TextEditingController inputFieldController,
    required TextEditingController unitFieldController,
    required RxInt selectedIndex,
    required List<String> unitList,
    required
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          flex: 4,
          child: CustomTextField5(
            controller: inputFieldController,
            title: inputFieldTitle,
            hintText: inputFieldHintText,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: CustomTextField5(
            controller: unitFieldController,
            hintText: unitFieldHintText,
            suffixIcon: Icons.unfold_more,
            readOnly: true,
            onTap: () {
              CustomBottomSheet1(
                selectedIndex: selectedIndex.value,
                list: viewModel.weightUnitList,
                onValueSelected: (value) {
                  viewModel.weightUnitSelectedIndex.value = value;
                  viewModel.weightUnitController.text = viewModel.weightUnitList[value];
                },
              ).show();
            },
          ),
        ),
      ],
    );
  }

  Widget weightTxtField() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          flex: 4,
          child: CustomTextField5(
            controller: viewModel.weightController,
            title: 'Weight',
            hintText: '0.0',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: CustomTextField5(
            controller: viewModel.weightUnitController,
            hintText: 'Unit',
            suffixIcon: Icons.unfold_more,
            readOnly: true,
            onTap: () {
              CustomBottomSheet1(
                selectedIndex: viewModel.weightUnitSelectedIndex.value,
                list: viewModel.weightUnitList,
                onValueSelected: (value) {
                  viewModel.weightUnitSelectedIndex.value = value;
                  viewModel.weightUnitController.text = viewModel.weightUnitList[value];
                },
              ).show();
            },
          ),
        ),
      ],
    );
  }

  Widget dimensionsSection() {
    return SizedBox(
      width: Get.width * 0.8,
      height: 200,
      child: Row(
        children: [
          lengthTxtField(),
          widthTxtField(),
          heightTxtField(),
        ],
      ),
    );
  }

  Widget lengthTxtField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomTextField5(
          controller: viewModel.lengthController,
          title: 'Length',
          hintText: '0.0',
        ),
        const SizedBox(width: 8),
        CustomTextField5(
          controller: viewModel.lengthUnitController,
          hintText: 'Unit',
          suffixIcon: Icons.unfold_more,
          readOnly: true,
          onTap: () {
            CustomBottomSheet1(
              selectedIndex: viewModel.lengthUnitSelectedIndex.value,
              list: viewModel.lengthUnitList,
              onValueSelected: (value) {
                viewModel.lengthUnitSelectedIndex.value = value;
                viewModel.lengthUnitController.text = viewModel.lengthUnitList[value];
              },
            ).show();
          },
        ),
      ],
    );
  }

  Widget widthTxtField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomTextField5(
          controller: viewModel.widthController,
          title: 'Width',
          hintText: '0.0',
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: CustomTextField5(
            controller: viewModel.widthUnitController,
            hintText: 'Unit',
            suffixIcon: Icons.unfold_more,
            readOnly: true,
            onTap: () {
              CustomBottomSheet1(
                selectedIndex: viewModel.widthUnitSelectedIndex.value,
                list: viewModel.widthUnitList,
                onValueSelected: (value) {
                  viewModel.widthUnitSelectedIndex.value = value;
                  viewModel.widthUnitController.text = viewModel.widthUnitList[value];
                },
              ).show();
            },
          ),
        ),
      ],
    );
  }

  Widget heightTxtField() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          flex: 4,
          child: CustomTextField5(
            controller: viewModel.heightController,
            title: 'Height',
            hintText: '0.0',
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: CustomTextField5(
            controller: viewModel.heightUnitController,
            hintText: 'Unit',
            suffixIcon: Icons.unfold_more,
            readOnly: true,
            onTap: () {
              CustomBottomSheet1(
                selectedIndex: viewModel.heightUnitSelectedIndex.value,
                list: viewModel.heightUnitList,
                onValueSelected: (value) {
                  viewModel.heightUnitSelectedIndex.value = value;
                  viewModel.heightUnitController.text = viewModel.heightUnitList[value];
                },
              ).show();
            },
          ),
        ),
      ],
    );
  }

  Widget countryRegionTxtField() {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 15),
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
    return const CustomTextField5(
      title: 'Harmonized System (HS) code',
      hintText: 'Search by product keyword or code',
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
