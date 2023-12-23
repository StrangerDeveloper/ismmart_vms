import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/screens/create_payout/create_payout_viewmodel.dart';
import 'package:ismmart_vms/widgets/custom_bottom_sheet.dart';
import 'package:ismmart_vms/widgets/custom_button.dart';
import 'package:ismmart_vms/widgets/custom_textfield.dart';
import 'package:ismmart_vms/widgets/scrollable_column.dart';

import '../../helper/theme_helper.dart';
import '../../widgets/custom_radiobtn.dart';

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
              isDropDown: true,
              onTap: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CustomTextField1(
              controller: viewModel.currencyController,
              title: 'Currency',
              hintText: 'Select Currency',
              isDropDown: true,
              onTap: () {
                CustomBottomSheet1(
                  selectedIndex: viewModel.currencySelectedIndex.value,
                  list: viewModel.currencyList,
                  onChanged: (value) {
                    viewModel.currencySelectedIndex.value = value;
                    viewModel.currencyController.text =
                        viewModel.currencyList[value];
                  },
                ).show();
              },
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
              isDropDown: true,
              onTap: () {},
            ),
          ),
          payoutType(),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
            child: CustomTextBtn(
              title: 'Save & Create',
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
        padding:
            const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
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
            Obx(
              () => (viewModel.radioBtn.value == 'automatic')
                  ? const Padding(
                      padding: EdgeInsets.only(left: 20, top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Set Time and Date to proceed transaction',
                            style: TextStyle(
                              color: ThemeHelper.grey5,
                              fontSize: 12,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8, bottom: 12),
                            child: CustomTextField1(
                              title: 'Date',
                              hintText: 'Enter Date',
                            ),
                          ),
                          CustomTextField1(
                            title: 'Time',
                            hintText: 'Enter Time',
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  taskTypeBtmSheet() {
    int tempIndex = 0;
    showModalBottomSheet(
      context: Get.context!,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CupertinoButton(
                child: const Text(
                  'Cancel',
                  style: TextStyle(fontSize: 14),
                ),
                onPressed: () {
                  Get.back();
                },
              ),
              Expanded(
                child: CupertinoPicker(
                  scrollController: FixedExtentScrollController(
                    initialItem: viewModel.currencySelectedIndex.value,
                  ),
                  itemExtent: 35,
                  onSelectedItemChanged: (int index) {
                    tempIndex = index;
                    // viewModel.currencySelectedIndex.value = index;
                    // viewModel.currencyController.text =  viewModel.currencyList[index];
                  },
                  children: List.generate(
                    viewModel.currencyList.length,
                    (int index) {
                      return Center(
                        child: Text(
                          viewModel.currencyList[index],
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              CupertinoButton(
                child: const Text(
                  'Done',
                  style: TextStyle(fontSize: 14),
                ),
                onPressed: () {
                  Get.back();
                  viewModel.currencySelectedIndex.value = tempIndex;
                  viewModel.currencyController.text =
                      viewModel.currencyList[tempIndex];
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
