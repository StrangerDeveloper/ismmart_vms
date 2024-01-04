import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/screens/add_product/add_product_3/add_product_3_viewmodel.dart';
import 'package:ismmart_vms/widgets/custom_button.dart';

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            stepperText(),
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
                  thisIsPhysicalProduct(),
                  weightTxtField(),
                  const Divider(),
                  countryRegionTxtField(),
                  hsCodeTxtField(),
                  continueSellingOFS(),
                  productHasSkuBarcode(),
                ],
              ),
            ),
            searchEngineListing(),
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
                onPressed: () {},
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

  Widget thisIsPhysicalProduct() {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 10),
      child: CustomCheckBox(
        value: viewModel.checkBoxIsPhysicalProduct,
        onChanged: (value) {
          viewModel.checkBoxIsPhysicalProduct.value = value;
        },
        child: const Text(
          'This is a physical product',
          style: TextStyle(
            color: ThemeHelper.grey2,
            fontSize: 10,
          ),
        ),
      ),
    );
  }

  Widget weightTxtField() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Expanded(
          flex: 4,
          child: CustomTextField5(
            title: 'Weight',
            hintText: '0.0',
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: CustomTextField5(
            controller: viewModel.unitController,
            hintText: '0.0',
            suffixIcon: Icons.unfold_more,
            readOnly: true,
            onTap: () {
              CustomBottomSheet1(
                selectedIndex: viewModel.unitSelectedIndex.value,
                list: viewModel.unitList,
                onValueSelected: (value) {
                  viewModel.unitSelectedIndex.value = value;
                  viewModel.unitController.text = viewModel.unitList[value];
                },
              ).show();
            },
          ),
        ),
      ],
    );
  }

  Widget countryRegionTxtField() {
    return const Padding(
      padding: EdgeInsets.only(top: 4, bottom: 15),
      child: CustomTextField5(
        title: 'Country/Region of origin',
        hintText: 'Rs 0.00',
        suffixIcon: Icons.unfold_more,
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

  Widget productHasSkuBarcode() {
    return CustomCheckBox(
      value: viewModel.checkBoxIsPhysicalProduct,
      onChanged: (value) {
        viewModel.checkBoxIsPhysicalProduct.value = value;
      },
      child: const Text(
        'This product has a SKU or barcode',
        style: TextStyle(
          color: ThemeHelper.grey2,
          fontSize: 10,
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
              Transform.scale(
                scale: 0.8,
                child: CupertinoSwitch(
                  value: false,
                  onChanged: (value) {},
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
