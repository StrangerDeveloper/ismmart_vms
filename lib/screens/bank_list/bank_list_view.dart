import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/screens/add_bank/add_bank_view.dart';
import 'package:ismmart_vms/screens/bank_list/bank_list_viewmodel.dart';

import '../../helper/theme_helper.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/loader_view.dart';

class BankListView extends StatelessWidget {
  BankListView({super.key});

  final BankListViewModel viewModel = Get.put(BankListViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank Details'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                searchTxtField(),
                note(),
                listView(),
                addNewBankBtn(),
              ],
            ),
          ),
          const LoaderView(),
        ],
      ),
    );
  }

  Widget searchTxtField() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: CustomTextField1(
        controller: viewModel.searchController,
        filled: false,
        prefixIcon: CupertinoIcons.search,
        hintText: 'Filter by name',
        onFieldSubmitted: (value) {
          viewModel.searchTxtFieldSubmitted(value);
        },
        suffixIconButton: IconButton(
          visualDensity: VisualDensity.compact,
          onPressed: () {
            if (viewModel.searchController.text.isEmpty) return;
            viewModel.searchController.clear();
            viewModel.searchTxtFieldSubmitted('');
          },
          icon: const Icon(
            Icons.close,
            color: ThemeHelper.grey2,
          ),
        ),
      ),
    );
  }

  Widget note() {
    return const Padding(
      padding: EdgeInsets.only(right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(
            CupertinoIcons.info_circle_fill,
            size: 12,
            color: Colors.red,
          ),
          SizedBox(width: 4),
          Text(
            'Note: Swipe left to delete',
            style: TextStyle(
              fontSize: 12,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget listView() {
    return Obx(
      () => viewModel.dataList.isNotEmpty
          ? ListView.separated(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: viewModel.dataList.length,
              itemBuilder: (context, int index) {
                return listViewItem(index);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 16);
              },
            )
          : const SizedBox(
              height: 200,
              child: Center(
                child: Text('No Data Found'),
              ),
            ),
    );
  }

  Widget listViewItem(int index) {
    return Dismissible(
      confirmDismiss: (confirmDismiss) {
        return deleteConfirmationDialog(index);
      },
      direction: DismissDirection.endToStart,
      background: Align(
        alignment: Alignment.centerRight,
        child: Container(
          height: 100,
          width: 60,
          decoration: BoxDecoration(
            color: ThemeHelper.blue1,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            CupertinoIcons.delete_simple,
            color: Colors.white,
          ),
        ),
      ),
      key: UniqueKey(),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          Get.to(
            () => AddBankView(),
            arguments: {
              'editData': true,
              'model': viewModel.dataList[index],
            },
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: const Color(0xFFF3F4F6)),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFF9FAFB),
                ),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Text(
                    viewModel
                        .getFirstTwoChar(viewModel.dataList[index].name ?? ''),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      viewModel.dataList[index].name ?? 'N/A',
                      style: const TextStyle(
                        color: ThemeHelper.blue1,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      viewModel.dataList[index].title ?? 'N/A',
                      style: const TextStyle(
                        color: ThemeHelper.grey5,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget addNewBankBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
      child: CustomTextBtn(
        height: 56,
        radius: 16,
        backgroundColor: ThemeHelper.grey3,
        foregroundColor: ThemeHelper.blue1,
        onPressed: () {
          Get.to(() => AddBankView(), arguments: {'editData': false});
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Add new bank',
              style: TextStyle(
                color: ThemeHelper.blue1,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: ThemeHelper.blue1,
            )
          ],
        ),
      ),
    );
  }

  Future showDeleteDisputeDialog() async {
    return showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('langKey.deleteDisputes.tr'),
          content: const Text('langKey.deleteDisputesMsg.tr'),
          actions: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: const Size(double.infinity, 40),
                      foregroundColor: Colors.grey,
                    ),
                    child: const Text(
                      'langKey.noBtn.tr',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(Get.context!).pop();
                    },
                  ),
                ),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: const Size(double.infinity, 40),
                      foregroundColor: Colors.grey,
                    ),
                    child: const Text(
                      'langKey.yesBtn.tr',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(Get.context!).pop();
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<bool> deleteConfirmationDialog(int index) async {
    final value = await showDialog<bool>(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Record'),
          content: const Text('Are you sure you want to delete?'),
          actions: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: const Size(double.infinity, 40),
                      foregroundColor: Colors.grey,
                    ),
                    child: const Text(
                      'No',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                ),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: const Size(double.infinity, 40),
                      foregroundColor: Colors.grey,
                    ),
                    child: const Text(
                      'Yes',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () {
                      viewModel.deleteRecord(index);
                      Navigator.of(context).pop(true);
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );

    return value ?? false;
  }
}
