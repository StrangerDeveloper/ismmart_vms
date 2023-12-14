import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/languages/translations_key.dart';
import 'package:ismmart_vms/screens/shippings/shippings_viewmodel.dart';
import 'package:ismmart_vms/widgets/custom_appbar.dart';
import 'package:ismmart_vms/widgets/custom_button.dart';
import 'package:ismmart_vms/widgets/custom_dropdown.dart';
import 'package:ismmart_vms/widgets/custom_section_divider.dart';

import '../../widgets/custom_textfield.dart';

class ShippingMethodsView extends StatelessWidget {
  ShippingMethodsView({super.key});
  final ShippingViewModel viewModel = Get.put(ShippingViewModel());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: CustomAppBar(title: shipping.tr),
      body: SingleChildScrollView(
        child: Form(
            key: viewModel.shippingFormKey,
            child: Column(
              children: [
                _shippingMethods(),
                _nameField(),
                _idField(),
                _rateSection(),
                _submitBtn(),
              ],
            )),
      ),
    ));
  }

  Widget _shippingMethods() {
    return CustomDropDownList1(
      title: 'Shipping Method',
      value: viewModel.shippingMethod,
      onChanged: (value) {
        viewModel.shippingMethod.value = value;
      },
      list: viewModel.shippingMethodList,
    );
  }

  Widget _nameField() {
    return const CustomTextField1(
      title: 'Name',
    );
  }

  Widget _idField() {
    return const CustomTextField1(
      title: 'ID',
    );
  }

  Widget _rateSection() {
    return Column(
      children: [
        const CustomSectionDivier(text: 'Rates'),
        _priceField(),
        _descriptionField(),
        _rangeField(),
        _typeDropDown(),
      ],
    );
  }

  Widget _priceField() {
    return const CustomTextField1(
      title: 'Price',
    );
  }

  _descriptionField() {
    return const CustomTextField1(
      title: 'Description',
    );
  }

  Widget _rangeField() {
    return const CustomTextField1(
      title: 'Range',
    );
  }

  Widget _typeDropDown() {
    return CustomDropDownList1(
      title: 'Types',
      value: viewModel.ratesType,
      onChanged: (value) {
        viewModel.ratesType.value = value;
      },
      list: viewModel.ratesTypeList,
    );
  }

  Widget _submitBtn() {
    return CustomTextBtn(
      onPressed: () {},
      title: 'Submit',
    );
  }
}
