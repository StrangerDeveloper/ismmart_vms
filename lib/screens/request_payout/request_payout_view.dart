import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/screens/request_payout/request_payout_viewmodel.dart';
import 'package:ismmart_vms/widgets/custom_button.dart';
import 'package:ismmart_vms/widgets/custom_dropdown.dart';
import 'package:ismmart_vms/widgets/custom_textfield.dart';

class RequestPayoutView extends StatelessWidget {
  RequestPayoutView({super.key});

  final RequestPayoutViewModel viewModel = Get.put(RequestPayoutViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Payout'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            CustomTextField1(
              title: 'Requested Date',
            ),
            SizedBox(height: 10),
            CustomTextField1(
              title: 'Amount',
            ),
            SizedBox(height: 10),
            CustomDropDownList1(
              title: 'Transfer Method',
              value: viewModel.transferMethodValue,
              onChanged: (value) {
                viewModel.transferMethodValue.value = value;
              },
              list: viewModel.transferMethodList,
            ),
            SizedBox(height: 10),
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
