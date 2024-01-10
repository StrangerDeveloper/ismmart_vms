// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ismmart_vms/screens/create_payout/create_payout_viewmodel.dart';
// import 'package:ismmart_vms/widgets/custom_bottom_sheet.dart';
// import 'package:ismmart_vms/widgets/custom_button.dart';
// import 'package:ismmart_vms/widgets/custom_textfield.dart';
// import 'package:ismmart_vms/widgets/scrollable_column.dart';
//
// import '../../helper/theme_helper.dart';
// import '../../widgets/custom_radiobtn.dart';
// import '../../widgets/loader_view.dart';
//
// class CreatePayoutView extends StatelessWidget {
//   CreatePayoutView({super.key});
//
//   final CreatePayoutViewModel viewModel = Get.put(CreatePayoutViewModel());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text('Create Payout'),
//       ),
//       body: Stack(
//         children: [
//           ScrollableColumn(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
//                 child: CustomTextField1(
//                   title: 'Select Vendor Name ',
//                   hintText: 'Select vendor name',
//                   controller: viewModel.vendorNameController,
//                   isDropDown: true,
//                   onTap: () {
//                     viewModel.resetValue();
//                     itemsBottomSheet();
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 child: CustomTextField1(
//                   controller: viewModel.currencyController,
//                   title: 'Currency',
//                   hintText: 'Select Currency',
//                   isDropDown: true,
//                   onTap: () {
//                     CustomBottomSheet1(
//                       selectedIndex: viewModel.currencySelectedIndex.value,
//                       list: viewModel.currencyList,
//                       onValueSelected: (value) {
//                         viewModel.currencySelectedIndex.value = value;
//                         viewModel.currencyController.text =
//                             viewModel.currencyList[value];
//                       },
//                     ).show();
//                   },
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 15, vertical: 18),
//                 child: CustomTextField1(
//                   title: 'Amount',
//                   hintText: 'Enter Amount',
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 child: CustomTextField1(
//                   title: 'Transfer Method',
//                   controller: viewModel.paymentTypeController,
//                   hintText: 'Select payment method',
//                   isDropDown: true,
//                   onTap: () {
//                     CustomBottomSheet1(
//                       selectedIndex: viewModel.paymentSelectedIndex.value,
//                       list: viewModel.paymentTypeList,
//                       onValueSelected: (value) {
//                         viewModel.paymentSelectedIndex.value = value;
//                         viewModel.paymentTypeController.text =
//                             viewModel.paymentTypeList[value];
//                       },
//                     ).show();
//                   },
//                 ),
//               ),
//               payoutType(),
//               const Spacer(),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
//                 child: CustomTextBtn(
//                   title: 'Save & Create',
//                   onPressed: () {},
//                 ),
//               ),
//             ],
//           ),
//           const LoaderView(),
//         ],
//       ),
//     );
//   }
//
//   Widget payoutType() {
//     return Container(
//       margin: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: ThemeHelper.grey3,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Padding(
//         padding:
//             const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Obx(
//               () => CustomRadioButton1(
//                 title: 'Manual',
//                 groupValue: viewModel.radioBtn.value,
//                 value: 'manual',
//                 onChanged: (value) {
//                   viewModel.radioBtn.value = value;
//                 },
//               ),
//             ),
//             Obx(
//               () => CustomRadioButton1(
//                 groupValue: viewModel.radioBtn.value,
//                 value: 'automatic',
//                 onChanged: (value) {
//                   viewModel.radioBtn.value = value;
//                 },
//                 title: 'Automatic',
//               ),
//             ),
//             Obx(
//               () => (viewModel.radioBtn.value == 'automatic')
//                   ? const Padding(
//                       padding: EdgeInsets.only(left: 20, top: 5),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Set Time and Date to proceed transaction',
//                             style: TextStyle(
//                               color: ThemeHelper.grey5,
//                               fontSize: 12,
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(top: 8, bottom: 12),
//                             child: CustomTextField1(
//                               title: 'Date',
//                               hintText: 'Enter Date',
//                             ),
//                           ),
//                           CustomTextField1(
//                             title: 'Time',
//                             hintText: 'Enter Time',
//                           ),
//                         ],
//                       ),
//                     )
//                   : const SizedBox(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   itemsBottomSheet() {
//     showModalBottomSheet(
//       context: Get.context!,
//       isScrollControlled: true,
//       backgroundColor: Colors.white,
//       shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(20), topRight: Radius.circular(20))),
//       constraints: BoxConstraints(maxHeight: Get.height * 0.9),
//       builder: (BuildContext context) {
//         return Padding(
//           padding: const EdgeInsets.fromLTRB(16, 10, 10, 3),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Icon(
//                     Icons.menu,
//                     color: ThemeHelper.blue1,
//                   ),
//                   const SizedBox(width: 10),
//                   const Text(
//                     'Select Vendor',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       color: ThemeHelper.blue1,
//                       fontSize: 16,
//                     ),
//                   ),
//                   const Spacer(),
//                   IconButton(
//                     onPressed: () {
//                       Get.back();
//                     },
//                     icon: const Icon(
//                       Icons.close,
//                       color: Colors.red,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               CustomTextField1(
//                 hintText: 'Search Vendor...',
//                 controller: viewModel.searchController,
//                 onChanged: (value) {
//                   viewModel.onSearch(value);
//                 },
//               ),
//               Obx(
//                 () => (viewModel.filteredCitiesList.isNotEmpty)
//                     ? Expanded(
//                         child: ListView.separated(
//                           padding: const EdgeInsets.symmetric(vertical: 10),
//                           itemCount: viewModel.filteredCitiesList.length,
//                           itemBuilder: (context, index) {
//                             return InkWell(
//                               borderRadius: BorderRadius.circular(8),
//                               onTap: () {
//                                 viewModel.vendorNameController.text =
//                                     viewModel.filteredCitiesList[index];
//                                 Get.back();
//                               },
//                               child: Padding(
//                                 padding: const EdgeInsets.all(12),
//                                 child:
//                                     Text(viewModel.filteredCitiesList[index]),
//                               ),
//                             );
//                           },
//                           separatorBuilder: (context, index) {
//                             return const SizedBox(height: 3);
//                           },
//                         ),
//                       )
//                     : const Padding(
//                         padding: EdgeInsets.only(top: 30),
//                         child: Text('No City Found'),
//                       ),
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
