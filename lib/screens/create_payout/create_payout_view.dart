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
              // readOnly: true,
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
      child: Padding(
        padding: EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => CustomRadioButton1(
                title: 'Manual',
                groupValue: viewModel.radioBtn.value,
                value: 'manual',
                onChanged: (value) {
                  viewModel.radioBtn.value = value;
                  print(value);
                },
              ),
            ),
            Obx(
              () => CustomRadioButton1(
                groupValue: viewModel.radioBtn.value,
                value: 'automatic',
                onChanged: (value) {
                  viewModel.radioBtn.value = value;
                  print(value);
                },
                title: 'Automatic',
              ),
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
  final String title;
  final String groupValue;
  final String value;
  final void Function(String) onChanged;

  const CustomRadioButton1({
    super.key,
    required this.groupValue,
    required this.value,
    required this.onChanged,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Material(
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () {
              onChanged(value);
            },
            child: Container(
              height: 16,
              width: 16,
              margin: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: value == groupValue
                    ? Border.all(
                        width: 3.5,
                        color: ThemeHelper.blue1,
                      )
                    : Border.all(
                        color: const Color(0xFFD1D5DB),
                      ),
              ),
            ),
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
