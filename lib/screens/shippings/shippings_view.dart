import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/languages/translations_key.dart';
import 'package:ismmart_vms/screens/shippings/shippings_viewmodel.dart';
import 'package:ismmart_vms/widgets/custom_appbar.dart';

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
    return Container();
  }

  Widget _nameField() {
    return Container();
  }

  Widget _idField() {
    return Container();
  }

  Widget _rateSection() {
    return Container();
  }

  Widget _submitBtn() {
    return Container();
  }
}
