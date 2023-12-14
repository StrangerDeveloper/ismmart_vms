import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/screens/add_location/add_location_viewmodel.dart';
import 'package:ismmart_vms/widgets/custom_button.dart';
import 'package:ismmart_vms/widgets/custom_textfield.dart';

class AddLocationView extends StatelessWidget {
  AddLocationView({super.key});

  final AddLocationViewModel viewModel = Get.put(AddLocationViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Address'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CustomTextField1(
              title: 'Name',
            ),
            const SizedBox(height: 10),
            const CustomTextField1(
              title: 'Country',
            ),
            const SizedBox(height: 10),
            const CustomTextField1(
              title: 'City ',
            ),
            const SizedBox(height: 10),
            const CustomTextField1(
              title: 'Address',
            ),
            const SizedBox(height: 10),
            const CustomTextField1(
              title: 'Phone No',
            ),
            const SizedBox(height: 10),
            CustomTextBtn(
              title: 'Submit',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
