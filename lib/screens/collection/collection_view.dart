// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ismmart_vms/helper/constants.dart';
// import 'package:ismmart_vms/screens/collection/collection_viewmodel.dart';
// import 'package:ismmart_vms/widgets/custom_appbar.dart';
// import 'package:ismmart_vms/widgets/custom_text.dart';
// import 'package:ismmart_vms/widgets/scrollable_column.dart';
// import 'package:path/path.dart';
// import 'package:quill_html_editor/quill_html_editor.dart';
//
// import '../../helper/theme_helper.dart';
// import '../../widgets/custom_button.dart';
// import '../../widgets/custom_radiobtn.dart';
// import '../../widgets/custom_textfield.dart';
// import '../../widgets/image_layout_container.dart';
//
// class CollectionView extends StatelessWidget {
//   CollectionView({super.key});
//   final CollectionViewModel viewModel = Get.put(CollectionViewModel());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               titleAndBackBtn(),
//               divider(),
//               shopNameField(),
//               cnicFrontImage(),
//               descriptionField(),
//               radioBtn(),
//               Obx(
//                 () => Padding(
//                   padding: const EdgeInsets.only(top: 25.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       CustomText(
//                         title: "Publishing",
//                         style: newFontStyleSize14.copyWith(
//                             fontWeight: FontWeight.w600),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 8.0, bottom: 18),
//                         child: CustomText(
//                           title: 'Will be included in 4 sales channels',
//                           style: newFontStyleSize12.copyWith(
//                               color: newColorLightGrey5),
//                         ),
//                       ),
//                       CustomText(
//                         title: 'Select all',
//                         style: newFontStyleSize12.copyWith(color: newColorBlue),
//                       ),
//                       SizedBox(
//                         height: 300,
//                         child: ListView.builder(
//                             itemCount: viewModel.publishingList.value.length,
//                             itemBuilder: (BuildContext context, int index) {
//                               return Row(
//                                 children: [
//                                   viewModel.publishingSelectedList
//                                           .contains(index)
//                                       ? IconButton(
//                                           onPressed: () {
//                                             viewModel.publishingSelectedList
//                                                 .removeWhere((e) => e == index);
//                                             print(viewModel
//                                                 .publishingSelectedList);
//                                           },
//                                           icon: Icon(
//                                             Icons.check_box,
//                                             color: newColorBlue,
//                                             size: 20,
//                                           ))
//                                       : IconButton(
//                                           onPressed: () {
//                                             viewModel.publishingSelectedList
//                                                 .add(index);
//                                             print(viewModel
//                                                 .publishingSelectedList);
//                                           },
//                                           icon: Icon(
//                                             Icons.check_box_outline_blank,
//                                             color: newColorLightGrey3,
//                                             size: 20,
//                                           )),
//                                   Expanded(
//                                     child: CustomText(
//                                       maxLines: 3,
//                                       title:
//                                           '${viewModel.publishingList[index]}',
//                                       style: newFontStyleSize12.copyWith(
//                                           color: newColorLightGrey3),
//                                     ),
//                                   ),
//                                 ],
//                               );
//                             }),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 50,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget titleAndBackBtn() {
//     return SizedBox(
//       width: double.infinity,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(bottom: 10.0),
//             child: CustomBackButton(onTap: () {
//               Get.back();
//             }),
//           ),
//           const SizedBox(width: 100),
//           Text(
//             'Create Collection',
//             style: newFontStyleSize20DM,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget divider() {
//     return const Divider(
//       color: Color(0xffEEEEEE),
//       thickness: 1,
//       height: 20,
//     );
//   }
//
//   Widget shopNameField() {
//     return Padding(
//       padding: const EdgeInsets.only(top: 24.0, bottom: 18),
//       child: CustomTextField1(
//         // prefixIcon: Icons.store,
//         keyboardType: TextInputType.text,
//         title: 'Title',
//         hintText: 'e.g. Summer collection, Under \$100...',
//         controller: viewModel.titleController,
//         autoValidateMode: AutovalidateMode.onUserInteraction,
//         // validator: (value) {
//         //   return Validator().validateName(value, errorToPrompt: langKey.storeNameReq.tr);
//         // },
//       ),
//     );
//   }
//
//   Widget cnicFrontImage() {
//     return Obx(
//       () => ImageLayoutContainer(
//         title: 'Collection Image',
//         filePath: viewModel.collectionImage.value == ''
//             ? ''
//             : basename(viewModel.collectionImage.value),
//         onTap: () async {
//           await viewModel.selectImage(viewModel.collectionImage,
//               viewModel.collectionImageErrorVisibility);
//         },
//         errorVisibility: viewModel.collectionImageErrorVisibility.value,
//         errorPrompt: 'CNIC Front Image is required',
//       ),
//     );
//   }
//
//   Widget descriptionField() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 18),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Description',
//             style: TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.only(top: 8),
//             decoration: textContainerDecoration,
//             child: Column(
//               children: [
//                 ToolBar(
//                   toolBarConfig: viewModel.customToolBarList,
//                   controller: viewModel.prodDescriptionController,
//                   toolBarColor: kDescriptionToolbarColor,
//                   iconColor: const Color(0xff929AAB),
//                 ),
//                 QuillHtmlEditor(
//                     hintTextAlign: TextAlign.center,
//                     hintText: 'Add Description ...',
//                     // text: 'Add description ...',
//                     textStyle: interNormalText.copyWith(
//                         color: Colors.black87, fontSize: 16),
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
//                     hintTextPadding:
//                         const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
//                     hintTextStyle: const TextStyle(
//                         color: newColorLightGrey2,
//                         fontWeight: FontWeight.normal,
//                         fontSize: 16),
//                     backgroundColor: kContainerFillColor,
//                     controller: viewModel.prodDescriptionController,
//                     minHeight: Get.height * 0.3),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget radioBtn() {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: ThemeHelper.grey3,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.only(left: 12, top: 10, bottom: 10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Obx(
//               () => CustomRadioButton3(
//                 title: 'Manual',
//                 child: RichText(
//                   maxLines: 2,
//                   text: TextSpan(
//                     children: [
//                       TextSpan(
//                           text:
//                               'Add products to this collection one by one. Learn more about ',
//                           style: newFontStyleSize12.copyWith(
//                               fontWeight: FontWeight.w400,
//                               color: newColorLightGrey5)),
//                       TextSpan(
//                           text: 'manual collections',
//                           style: newFontStyleSize12.copyWith(
//                               fontWeight: FontWeight.w400,
//                               color: newColorBlue)),
//                     ],
//                   ),
//                 ),
//                 groupValue: viewModel.radioBtn.value,
//                 value: 'manual',
//                 onChanged: (value) {
//                   viewModel.radioBtn.value = value;
//                 },
//               ),
//             ),
//             Obx(
//               () => CustomRadioButton3(
//                 title: 'Automatic',
//                 groupValue: viewModel.radioBtn.value,
//                 value: 'automatic',
//                 onChanged: (value) {
//                   viewModel.radioBtn.value = value;
//                 },
//                 child: RichText(
//                   maxLines: 4,
//                   text: TextSpan(
//                     children: [
//                       TextSpan(
//                           text:
//                               'Existing and future products that match the conditions you set will automatically be added to this collection. Learn more about ',
//                           style: newFontStyleSize12.copyWith(
//                               fontWeight: FontWeight.w400,
//                               color: newColorLightGrey5)),
//                       TextSpan(
//                           text: 'automated collections',
//                           style: newFontStyleSize12.copyWith(
//                               fontWeight: FontWeight.w400,
//                               color: newColorBlue)),
//                     ],
//                   ),
//                 ),
//                 // title: 'Automatic',
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
// }
