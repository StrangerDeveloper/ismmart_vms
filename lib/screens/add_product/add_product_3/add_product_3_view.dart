import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/screens/add_product/add_product_3/add_product_3_viewmodel.dart';

import '../../../helper/constants.dart';
import '../../../helper/theme_helper.dart';
import '../../../widgets/custom_checkbox.dart';
import '../../../widgets/custom_textfield.dart';

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            stepperText(),
            Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.menu,
                      color: ThemeHelper.blue1,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Set Price',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: ThemeHelper.blue1,
                        fontSize: 14,
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
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
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
                      CustomCheckBox(
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
                      const CustomTextField5(
                        title: 'Weight',
                        hintText: '0.0',
                      ),
                      const Divider(),
                      const Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 8),
                        child: CustomTextField5(
                          title: 'Country/Region of origin',
                          hintText: 'Rs 0.00',
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: CustomTextField5(
                          title: 'Harmonized System (HS) code',
                          hintText: 'Search by product keyword or code',
                        ),
                      ),
                      CustomCheckBox(
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
                      CustomCheckBox(
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
                      ),
                    ],
                  ),
                ),
              ],
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

  Widget stepperText() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 25),
      child: RichText(
        overflow: TextOverflow.ellipsis,
        text: const TextSpan(
          style: TextStyle(
            color: ThemeHelper.blue1,
            fontWeight: FontWeight.w500,
          ),
          children: [
            TextSpan(
              text: "  /  ",
              style: TextStyle(
                color: ThemeHelper.grey6,
              ),
            ),
            TextSpan(
              text: "Product & Pricing ",
              style: TextStyle(
                color: ThemeHelper.grey2,
              ),
            ),
            TextSpan(
              text: "  /  ",
              style: TextStyle(
                color: ThemeHelper.grey6,
              ),
            ),
            TextSpan(
              text: "Variant Setting",
              style: TextStyle(
                color: ThemeHelper.grey2,
              ),
            ),
            TextSpan(
              text: "  /  ",
              style: TextStyle(
                color: ThemeHelper.grey6,
              ),
            ),
            TextSpan(
              text: "Shipping",
            ),
          ],
        ),
      ),
    );
  }
}
