import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/theme_helper.dart';
import 'package:ismmart_vms/screens/add_location/add_location_viewmodel.dart';
import 'package:ismmart_vms/widgets/custom_button.dart';
import 'package:ismmart_vms/widgets/custom_textfield.dart';

class AddLocationView extends StatelessWidget {
  AddLocationView({super.key});

  final AddLocationViewModel viewModel = Get.put(AddLocationViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Add Address'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CustomTextField1(
              title: 'Name',
              hintText: 'e.g. Beverly Center, Islamabad',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: CustomTextField1(
                title: 'Country',
                hintText: 'Select the country',
                onTap: (){},
                isDropDown: true,
              ),
            ),
            CustomTextField1(
              title: 'City ',
              hintText: 'Select the city',
              isDropDown: true,
              onTap: () {
                itemsBottomSheet();
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 18),
              child: CustomTextField1(
                title: 'Address',
                hintText: 'Enter your Address here...',
                maxLines: 8,
                filled: false,
              ),
            ),
            CustomTextField1(
              title: 'Status',
              hintText: 'Select the Status',
              readOnly: true,
              isDropDown : true,
              onTap: () {
                itemsBottomSheet();
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 5),
              child: CustomTextBtn(
                title: 'Save & Create',
                onPressed: () {},
              ),
            ),
            CustomTextBtn(
              title: 'Discard',
              backgroundColor: Colors.black,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  itemsBottomSheet() {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      constraints: BoxConstraints(maxHeight: Get.height * 0.7),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 10, 3),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.menu,
                    color: ThemeHelper.blue1,
                  ),
                  const SizedBox(),
                  const Text(
                    'Select City',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
