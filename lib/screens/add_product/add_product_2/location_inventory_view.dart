import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/screens/add_product/add_product_2/add_product_2_view.dart';

import '../../../helper/constants.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textfield.dart';

class LocationInventoryView extends StatelessWidget {
  const LocationInventoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: newColorLightGrey2,
                  ),
                  const SizedBox(width: 10),
                  _textContainer("Location & Inventory"),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _textContainer("Variant"),
                      _textContainer("Price"),
                      _textContainer("Quantity"),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _textContainer("Green"),
                      const SizedBox(width: 20),
                      _buildField2("Rs 0.00"),
                      const SizedBox(width: 20),
                      _buildField2("0"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  hsCodeTxtField('SKU (Stock Keeping Unit)'),
                  const SizedBox(height: 20),
                  hsCodeTxtField('Barcode (ISBN, UPC, GTIN, etc.)'),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _textContainer("Black"),
                      const SizedBox(width: 20),
                      _buildField2("Rs 0.00"),
                      const SizedBox(width: 20),
                      _buildField2("0"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  hsCodeTxtField('SKU (Stock Keeping Unit)'),
                  const SizedBox(height: 20),
                  hsCodeTxtField('Barcode (ISBN, UPC, GTIN, etc.)'),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _textContainer("Red"),
                      const SizedBox(width: 20),
                      _buildField2("Rs 0.00"),
                      const SizedBox(width: 20),
                      _buildField2("0"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  hsCodeTxtField('SKU (Stock Keeping Unit)'),
                  const SizedBox(height: 20),
                  hsCodeTxtField('Barcode (ISBN, UPC, GTIN, etc.)'),
                  const Divider(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 5),
                child: CustomTextBtn(
                  title: 'Done',
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
          onPressed: () => Get.to(() => AddProduct2View()),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 22,
            color: newColorLightGrey2,
          )),
      title: Text(
        'Add Product',
        style: dmSerifDisplay1.copyWith(fontSize: 20),
      ),
      centerTitle: true,
    );
  }

  Widget _textContainer(String text) {
    return Text(
      text,
      //style: dmSerifDisplay1.copyWith(fontSize: 20),
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
    );
  }

  Widget _buildField2(String var1) {
    return Expanded(
      child: CustomTextField5(
        hintText: var1,
        suffixIcon: Icons.unfold_more,
      ),
    );
  }

  Widget hsCodeTxtField(String title) {
    return CustomTextField5(
      title: title,
      //hintText: 'Search by product keyword or code',
    );
  }
}
