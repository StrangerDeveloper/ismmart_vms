import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/screens/add_user/add_user_viewmodel.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_checkbox.dart';
import '../../widgets/custom_textfield.dart';

class AddUserView extends StatelessWidget {
  AddUserView({super.key});

  final AddUserViewModel viewModel = Get.put(AddUserViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Permissions',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
            const Divider(),
            permissionItem(
              title: 'Products',
              add: viewModel.productAdd,
              edit: viewModel.productEdit,
              delete: viewModel.productDelete,
            ),
            permissionItem(
              title: 'Orders',
              add: viewModel.orderAdd,
              edit: viewModel.orderEdit,
              delete: viewModel.orderDelete,
            ),
            permissionItem(
              title: 'Settings',
              add: viewModel.settingsAdd,
              edit: viewModel.settingsEdit,
              delete: viewModel.settingsDelete,
            ),
            permissionItem(
              title: 'Payouts',
              add: viewModel.payoutsAdd,
              edit: viewModel.payoutsEdit,
              delete: viewModel.payoutsDelete,
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

  Widget permissionItem({
    required String title,
    required RxBool add,
    required RxBool edit,
    required RxBool delete,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      decoration: BoxDecoration(
          border: Border.all(width: 0.5),
          borderRadius: BorderRadius.circular(4)),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomCheckBox(
                title: 'Add',
                value: add,
                onChanged: (value) {
                  add.value = value;
                },
              ),
              CustomCheckBox(
                title: 'Edit',
                value: edit,
                onChanged: (value) {
                  edit.value = value;
                },
              ),
              CustomCheckBox(
                title: 'Delete',
                value: delete,
                onChanged: (value) {
                  delete.value = value;
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
