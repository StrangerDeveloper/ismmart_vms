import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/screens/create_payout/create_payout_viewmodel.dart';
import 'package:ismmart_vms/widgets/custom_button.dart';
import 'package:ismmart_vms/widgets/custom_textfield.dart';
import 'package:ismmart_vms/widgets/scrollable_column.dart';

import '../../helper/theme_helper.dart';

class CreatePayoutView extends StatelessWidget {
  CreatePayoutView({super.key});

  final CreatePayoutViewModel viewModel = Get.put(CreatePayoutViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Create Payout'),
      ),
      body: ScrollableColumn(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
            child: CustomTextField1(
              title: 'Select Vendor Name ',
              hintText: 'Select vendor name',
              readOnly: true,
              isDropDown: true,
              onTap: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CustomTextField1(
              title: 'Currency',
              hintText: 'Select Currency',
              readOnly: true,
              isDropDown: true,
              onTap: () {},
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 18),
            child: CustomTextField1(
              title: 'Amount',
              hintText: 'Enter Amount',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CustomTextField1(
              title: 'Transfer Method',
              hintText: 'Select payment method',
              readOnly: true,
              isDropDown: true,
              onTap: () {},
            ),
          ),
          payoutType(),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
            child: CustomTextBtn(
              title: 'Submit',
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget payoutType() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ThemeHelper.grey3,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Padding(
        padding:
            EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomRadioButton1(
              groupValue: 'helo',
              value: 'hello',
            ),
            CustomRadioButton1(
              groupValue: 'helo',
              value: 'hellosa',
            ),
            CustomTextField1(
              title: 'Date',
              hintText: 'Enter Date',
            ),
            CustomTextField1(
              title: 'Time',
              hintText: 'Enter Time',
            ),
          ],
        ),
      ),
    );
  }
}

class CustomRadioButton1 extends StatelessWidget {
  final String groupValue;
  final String value;
  final void Function(String?)? onChanged;

  const CustomRadioButton1({
    super.key,
    required this.groupValue,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Material(
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () {},
            child: Container(
              height: 20,
              width: 20,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: value == groupValue
                    ? Border.all(
                        color: const Color(0xFFD1D5DB),
                      )
                    : Border.all(
                        width: 3.5,
                        color: ThemeHelper.blue1,
                      ),
              ),
            ),
          ),
        ),
        const Text(
          'Manual',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
