import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/screens/add_product/add_product_1/add_product_1_view.dart';
import 'package:ismmart_vms/screens/add_product/add_product_2/add_product_2_viewmodel.dart';
import 'package:ismmart_vms/widgets/custom_button.dart';

import '../../../helper/constants.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/widget_models/variant_options_field_model.dart';

class AddProduct2View extends StatelessWidget {
  AddProduct2View({super.key});

  final AddProduct2ViewModel viewModel = Get.put(AddProduct2ViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              stepperText(),
              variantsContainer(context),
              inventoryContainer()
            ],
          ),
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(onPressed: () => Get.to(() => AddProduct1View()), icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 22, color: newColorLightGrey2,)),
      title: Text(
          'Add Product',
        style: dmSerifDisplay1.copyWith(fontSize: 20),
      ),
      centerTitle: true,
    );
  }

  Widget stepperText() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
              Icons.verified,
            size: 18,
            color: newColorBlue,
          ),
          Text(
            '  Product & Pricing',
            style: stepperTextStyle,
          ),
          const Text(
              ' / ',
            style: TextStyle(color: newColorLightGrey2),
          ),
          Text(
            'Variant Setting',
            style: stepperTextStyle,
          ),
          const Text(
              ' / ',
            style: TextStyle(color: newColorLightGrey2),
          ),
          Text(
            'Shipping',
            style: stepperTextStyle.copyWith(
              color: Colors.black
            ),
          )
        ],
      )
    );
  }

  Widget variantsContainer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: textContainerDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Variants',
              style: interHeadingSize14,
            ),
            variantAdditionField(context)
          ],
        ),
      ),
    );
  }

  Widget variantAdditionField(BuildContext context) {
    return Obx(() =>
    viewModel.showVariantsField.value ? const Column(
      children: [
        SizedBox()
      ],
    ) : TextButton(
        onPressed: () async {
          viewModel.listOfOptionsAdded.add(VariantsOptionsFieldModel(optionName: '', optionValues: [TextEditingController()]));
          await variantSelectionDialog();
        },
        child: Align(
            alignment: Alignment.centerLeft, child: Text(
            '+ Add options like color or size',
          style: interNormalText.copyWith(
            color: newColorBlue,
            fontSize: 12
          ),
        ),
        ),
    ),
    );
  }

  Future variantSelectionDialog() {
    return showModalBottomSheet(
        context: Get.context!,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        builder: (BuildContext context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Form(
              key: viewModel.variantsFormKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
                child: SingleChildScrollView(
                  controller: viewModel.scrollController,
                  physics: const ScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                                'Variants',
                                style: interHeadingSize14.copyWith(color: newColorBlue)
                            ),
                          ),
                          IconButton(
                            visualDensity: VisualDensity.compact,
                            onPressed: () {
                              viewModel.listOfOptionsAdded.clear();
                              viewModel.listOfOptionsAdded.refresh();
                              viewModel.showVariantsField.value = false;
                              viewModel.showVariantsTable.value = false;
                              Get.back();
                            },
                            icon: const Icon(Icons.close, color: Colors.red,),
                          ),
                        ],
                      ),
                      const Divider(),
                       Column(
                            children: [
                              CustomTextField4(
                                title: 'Option Name',
                                hintText: 'Name your variant',
                                onChanged: (value) {
                                  viewModel.listOfOptionsAdded.last.optionName = value;
                                  viewModel.listOfOptionsAdded.refresh();
                                },
                                validator: (value) {
                                  if(value == null || value == "" || value.isEmpty) {
                                    return 'Enter name for variant';
                                  } else {
                                    return null;
                                  }
                                },
                                iconOnTap: () {
                                  if(viewModel.listOfOptionsAdded.length == 1) {
                                    viewModel.listOfOptionsAdded.clear();
                                    viewModel.listOfOptionsAdded.refresh();
                                    Get.back();
                                  } else {
                                    viewModel.listOfOptionsAdded.removeLast();
                                    viewModel.listOfOptionsAdded.refresh();
                                  }
                                },
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Divider(thickness: 0.8, color: kLightColor,),
                              ),
                              Obx(() => viewModel.listOfOptionsAdded.isEmpty ? const SizedBox() :
                                ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: viewModel.listOfOptionsAdded.last.optionValues?.length,
                                    itemBuilder: (context, optionIndex) {
                                      String? title;
                                      if(viewModel.listOfOptionsAdded.last.optionValues![optionIndex] == viewModel.listOfOptionsAdded.last.optionValues?.first){
                                        title = 'Option Values';
                                      }
                                      if (optionIndex == viewModel.listOfOptionsAdded.last.optionValues!.length - 1) {
                                        return Padding(
                                          padding: const EdgeInsets.only(bottom: 5.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              CustomTextField4(
                                                hintText: 'Add value',
                                                title: title,
                                                onChanged: (value) {
                                                  viewModel.listOfOptionsAdded.last.optionValues![optionIndex].text = value;
                                                  viewModel.listOfOptionsAdded.refresh();
                                                  },
                                                validator: (value) {
                                                  if (value == null || value == '' || value.isEmpty) {
                                                    return 'Enter value to proceed';
                                                  } else {
                                                    return null;
                                                  }
                                                  },
                                                iconOnTap: () {
                                                  viewModel.listOfOptionsAdded.last.optionValues!.removeAt(optionIndex);
                                                  // if(viewModel.listOfOptionsAdded.last.optionValues?.length == 1) {
                                                  //   viewModel.listOfOptionsAdded.removeLast();
                                                  //   viewModel.listOfOptionsAdded.refresh();
                                                  //   Get.back();
                                                  // } else {
                                                  //   viewModel.listOfOptionsAdded.last.optionValues?.removeAt(optionIndex);
                                                  //   viewModel.listOfOptionsAdded.refresh();
                                                  // }
                                                },
                                              ),
                                              TextButton(
                                                  onPressed: () {
                                                    if (viewModel.listOfOptionsAdded.last.optionValues![optionIndex].text == "" || viewModel.listOfOptionsAdded.last.optionValues![optionIndex].text.isEmpty) {
                                                      AppConstant.displaySnackBar('Error', 'Enter Value to add more fields');
                                                    } else {
                                                      viewModel.listOfOptionsAdded.last.optionValues?.add(TextEditingController());
                                                      viewModel.listOfOptionsAdded.refresh();
                                                    }
                                                  },
                                                  child: Text(
                                                    'Add another value',
                                                    style: interNormalText.copyWith(color: newColorBlue),
                                                  )
                                              )
                                            ],
                                          ),
                                        );
                                      } else {
                                        return Padding(
                                          padding: const EdgeInsets.only(bottom: 5.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              CustomTextField4(
                                                hintText: 'Add value',
                                                title: title,
                                                iconOnTap: () {
                                                  viewModel.listOfOptionsAdded.last.optionValues?.removeAt(optionIndex);
                                                    // viewModel.listOfOptionsAdded.last.optionValues?.removeWhere((element) => element.text == viewModel.listOfOptionsAdded.last.optionValues![optionIndex].text);
                                                    // viewModel.listOfOptionsAdded.refresh();
                                                },
                                                onChanged: (value) {
                                                  viewModel.listOfOptionsAdded.last.optionValues![optionIndex].text = value;
                                                  viewModel.listOfOptionsAdded.refresh();
                                                },
                                                validator: (value) {
                                                  if (value == null || value == '' || value.isEmpty) {
                                                    return 'Enter value to proceed';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                    }
                                ),
                              ),
                           ]
                      ),
                      // ListView.builder(
                      //     padding: const EdgeInsets.only(bottom: 10),
                      //     shrinkWrap: true,
                      //     physics: ScrollPhysics(),
                      //     itemCount: viewModel.listOfOptionsAdded.length,
                      //     itemBuilder: (context, index) {
                      //       TextEditingController optionName = TextEditingController();
                      //       optionName.text = viewModel.listOfOptionsAdded[index].optionName!;
                      //       return Column(
                      //         children: [
                      //           CustomTextField4(
                      //             title: 'Option Name',
                      //             hintText: 'Name your variant',
                      //             controller: optionName,
                      //             onChanged: (value) {
                      //               viewModel.listOfOptionsAdded[index].optionName = value;
                      //               viewModel.listOfOptionsAdded.refresh();
                      //               },
                      //             validator: (value) {
                      //               if(value == null || value == "" || value.isEmpty) {
                      //                 return 'Enter name for variant';
                      //               } else {
                      //                 return null;
                      //               }
                      //             },
                      //             iconOnTap: () {
                      //               if(viewModel.listOfOptionsAdded.length == 1) {
                      //                 viewModel.listOfOptionsAdded.clear();
                      //                 viewModel.listOfOptionsAdded.refresh();
                      //                 Get.back();
                      //               } else {
                      //                 viewModel.listOfOptionsAdded.removeAt(index);
                      //                 viewModel.listOfOptionsAdded.refresh();
                      //               }
                      //             },
                      //           ),
                      //           const Padding(
                      //             padding: EdgeInsets.symmetric(vertical: 5.0),
                      //             child: Divider(thickness: 0.8, color: kLightColor,),
                      //           ),
                      //           Obx(() => viewModel.listOfOptionsAdded.isEmpty ? const SizedBox() :
                      //               Column(
                      //                 children: viewModel.listOfOptionsAdded[index].optionValues!.map((e2) {
                      //                         TextEditingController optionController = e2;
                      //                         String? title;
                      //                         if(optionController == viewModel.listOfOptionsAdded[index].optionValues?.first){
                      //                           title = 'Option Values';
                      //                         }
                      //                         if (e2 == viewModel.listOfOptionsAdded[index].optionValues!.last) {
                      //                           return Padding(
                      //                             padding: const EdgeInsets.only(bottom: 5.0),
                      //                             child: Column(
                      //                               crossAxisAlignment: CrossAxisAlignment.start,
                      //                               children: [
                      //                                 CustomTextField4(
                      //                                   hintText: 'Add value',
                      //                                   title: title,
                      //                                   onChanged: (value) {
                      //                                     optionController.text = value;
                      //                                     },
                      //                                   iconOnTap: () {
                      //                                     if(viewModel.listOfOptionsAdded[index].optionValues?.length == 1) {
                      //                                       viewModel.listOfOptionsAdded.removeAt(index);
                      //                                       viewModel.listOfOptionsAdded.refresh();
                      //                                       if(viewModel.listOfOptionsAdded.isEmpty){
                      //                                         Get.back();
                      //                                       }
                      //                                     } else {
                      //                                         viewModel.listOfOptionsAdded[index].optionValues?.removeWhere((element) => element == e2);
                      //                                         viewModel.listOfOptionsAdded.refresh();
                      //                                     }
                      //                                     // if(optionIndex == 0) {
                      //                                     //   viewModel.listOfOptionsAdded.removeAt(index);
                      //                                     //   viewModel.listOfOptionsAdded.refresh();
                      //
                      //                                     // } else {
                      //                                     // }
                      //                                   },
                      //                                 ),
                      //                                 TextButton(
                      //                                     onPressed: () {
                      //                                       if (optionController.text == "" || optionController.text.isEmpty) {
                      //                                         AppConstant.displaySnackBar('Error', 'Enter Value to add more fields');
                      //                                       } else {
                      //                                         viewModel.listOfOptionsAdded[index].optionValues?.add(TextEditingController());
                      //                                         viewModel.listOfOptionsAdded.refresh();
                      //                                       }
                      //                                     },
                      //                                     child: Text(
                      //                                       'Add another value',
                      //                                       style: interNormalText.copyWith(color: newColorBlue),
                      //                                     )
                      //                                 )
                      //                               ],
                      //                             ),
                      //                           );
                      //                         } else {
                      //                           return Padding(
                      //                             padding: const EdgeInsets
                      //                                 .only(bottom: 5.0),
                      //                             child: Column(
                      //                               crossAxisAlignment: CrossAxisAlignment
                      //                                   .start,
                      //                               children: [
                      //                                 CustomTextField4(
                      //                                   hintText: 'Add value',
                      //                                   title: title,
                      //                                   onChanged: (value) {
                      //                                     optionController
                      //                                         .text = value;
                      //                                   },
                      //                                   validator: (value) {
                      //                                     if (value == null ||
                      //                                         value == '' ||
                      //                                         value.isEmpty) {
                      //                                       return 'Enter value to proceed';
                      //                                     } else {
                      //                                       return null;
                      //                                     }
                      //                                   },
                      //                                 ),
                      //                               ],
                      //                             ),
                      //                           );
                      //                         }
                      //                 }).toList(),
                      //               )
                      //               // ListView.builder(
                      //               //     physics: const NeverScrollableScrollPhysics(),
                      //               //     shrinkWrap: true,
                      //               //     itemCount: viewModel.listOfOptionsAdded[index].optionValues?.length,
                      //               //     itemBuilder: (context, optionIndex) {
                      //               //       TextEditingController optionController = viewModel.listOfOptionsAdded[index].optionValues![optionIndex];
                      //               //       String? title;
                      //               //       if(optionController == viewModel.listOfOptionsAdded[index].optionValues?.first){
                      //               //         title = 'Option Values';
                      //               //       }
                      //               //       if (optionIndex == viewModel.listOfOptionsAdded[index].optionValues!.length - 1) {
                      //               //         return Padding(
                      //               //           padding: const EdgeInsets.only(bottom: 5.0),
                      //               //           child: Column(
                      //               //             crossAxisAlignment: CrossAxisAlignment.start,
                      //               //             children: [
                      //               //               CustomTextField4(
                      //               //                 hintText: 'Add value',
                      //               //                 title: title,
                      //               //                 onChanged: (value) {
                      //               //                   optionController.text = value;
                      //               //                   },
                      //               //                 iconOnTap: () {
                      //               //                   if(viewModel.listOfOptionsAdded[index].optionValues?.length == 1) {
                      //               //                     viewModel.listOfOptionsAdded.removeAt(index);
                      //               //                     viewModel.listOfOptionsAdded.refresh();
                      //               //                     if(viewModel.listOfOptionsAdded.isEmpty){
                      //               //                       Get.back();
                      //               //                     }
                      //               //                   } else {
                      //               //                       viewModel.listOfOptionsAdded[index].optionValues?.removeAt(optionIndex);
                      //               //                       viewModel.listOfOptionsAdded.refresh();
                      //               //                   }
                      //               //                   // if(optionIndex == 0) {
                      //               //                   //   viewModel.listOfOptionsAdded.removeAt(index);
                      //               //                   //   viewModel.listOfOptionsAdded.refresh();
                      //               //
                      //               //                   // } else {
                      //               //                   // }
                      //               //                 },
                      //               //               ),
                      //               //               TextButton(
                      //               //                   onPressed: () {
                      //               //                     if (optionController.text == "" || optionController.text.isEmpty) {
                      //               //                       AppConstant.displaySnackBar('Error', 'Enter Value to add more fields');
                      //               //                     } else {
                      //               //                       viewModel.listOfOptionsAdded[index].optionValues?.add(TextEditingController());
                      //               //                       viewModel.listOfOptionsAdded.refresh();
                      //               //                     }
                      //               //                   },
                      //               //                   child: Text(
                      //               //                     'Add another value',
                      //               //                     style: interNormalText.copyWith(color: newColorBlue),
                      //               //                   )
                      //               //               )
                      //               //             ],
                      //               //           ),
                      //               //         );
                      //               //       } else {
                      //               //         return Padding(
                      //               //           padding: const EdgeInsets.only(bottom: 5.0),
                      //               //           child: Column(
                      //               //             crossAxisAlignment: CrossAxisAlignment.start,
                      //               //             children: [
                      //               //               CustomTextField4(
                      //               //                 hintText: 'Add value',
                      //               //                 title: title,
                      //               //                 onChanged: (value) {
                      //               //                   optionController.text = value;
                      //               //                 },
                      //               //                 validator: (value) {
                      //               //                   if(value == null || value == '' || value.isEmpty){
                      //               //                     return 'Enter value to proceed';
                      //               //                   } else {
                      //               //                     return null;
                      //               //                   }
                      //               //                 },
                      //               //               ),
                      //               //             ],
                      //               //           ),
                      //               //         );
                      //               //       }
                      //               //     }
                      //               // ),
                      //           ),
                      //           Obx(() =>  index == viewModel.listOfOptionsAdded.length-1 ? const SizedBox() : const Padding(
                      //             padding: EdgeInsets.symmetric(vertical: 8),
                      //             child: Divider(thickness: 1.3, color: Colors.black,),
                      //           ),
                      //           ),
                      //         ],
                      //       );
                      //     }
                      // ),
                      // TextButton(
                      //   onPressed: (){
                      //     viewModel.listOfOptionsAdded.add(
                      //         VariantsOptionsFieldModel(
                      //             optionName: '',
                      //             optionValues: [TextEditingController()]
                      //         )
                      //     );
                      //     viewModel.listOfOptionsAdded.refresh();
                      //   },
                      //   child: Align(
                      //     alignment: Alignment.centerLeft,
                      //     child: Text(
                      //         '+ Add another Option',
                      //       style: interNormalText.copyWith(
                      //           color: newColorBlue,
                      //           fontSize: 16,
                      //           fontWeight: FontWeight.w600
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      CustomRoundedTextBtn(
                        onPressed: () {
                          if(viewModel.variantsFormKey.currentState!.validate()){
                            Get.back();
                          }
                        },
                        title: 'Done',
                        borderRadius: 8,
                        backgroundColor: newColorBlue,
                      ),
                      // ListView.builder(
                      //   shrinkWrap: true,
                      //   itemCount: viewModel.optionsList.length,
                      //   itemBuilder: (context, index) {
                      //     return BottomSheetItem(
                      //       title: viewModel.optionsList[index],
                      //       onTap: () {
                      //         if(viewModel.optionsChosen.contains(viewModel.optionsList[index])){
                      //           AppConstant.displaySnackBar('Error', 'Option Already Selected');
                      //         } else {
                      //           if (viewModel.optionsList[index] == 'Other') {
                      //             viewModel.listOfOptionsAdded.add(
                      //                 VariantsOptionsFieldModel(
                      //                     optionName: '',
                      //                     optionValues: <TextEditingController>[TextEditingController()]
                      //                 )
                      //             );
                      //             viewModel.listOfOptionsAdded.refresh();
                      //             Navigator.pop(context);
                      //           } else {
                      //             viewModel.selectedOption.value =
                      //             viewModel.optionsList[index];
                      //             viewModel.listOfOptionsAdded.add(
                      //               VariantsOptionsFieldModel(
                      //                   optionName: viewModel.optionsList[index],
                      //                   optionValues: <TextEditingController>[
                      //                     TextEditingController()
                      //                   ]
                      //               ),
                      //             );
                      //             viewModel.optionsChosen.add(viewModel.optionsList[index]);
                      //             viewModel.listOfOptionsAdded.refresh();
                      //             viewModel.optionsChosen.refresh();
                      //             Navigator.pop(context);
                      //           }
                      //         }
                      //       },
                      //     );
                      //   },
                      // )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }

  Widget variantsTable() {
    return Container(
      color: Colors.grey.shade100,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Column(
        children: [
          CustomDropDownList1(
              value: viewModel.locationSelected,
              onChanged: (value) {
                viewModel.locationSelected.value = value;
              },
              dropdownList: viewModel.locationsList
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
                onPressed: (){},
                icon: const Icon(
                  Icons.more_horiz_rounded,
                  size: 20,
                  color: Colors.black,
                )
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: viewModel.finalCombinationsList.length,
            itemBuilder: (context, index){
              return Row(
                children: [
                  Checkbox(
                    value: viewModel.finalCombinationsList[index].variantSelected,
                    onChanged: (value) {
                      viewModel.finalCombinationsList[index].variantSelected = value;
                      viewModel.finalCombinationsList.refresh();
                    },
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    viewModel.finalCombinationsList[index].variantName!,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w400
                    ),
                  ),

                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget inventoryContainer() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        decoration: textContainerDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Inventory',
              style: interHeadingSize14,
            ),
            Text(
              'Inventory will be stocked at',
              style: interNormalText.copyWith(color: newColorLightGrey2),
            ),
            Row(
              children: [
                Obx(() => Checkbox(
                    side: const BorderSide(
                        color: newColorBlue
                    ),
                    fillColor: viewModel.trackQuantity.value ? MaterialStateColor.resolveWith((states) => newColorBlue) : MaterialStateColor.resolveWith((states) => Colors.white),
                    checkColor: Colors.white,
                    value: viewModel.trackQuantity.value,
                    onChanged: (value) {
                      viewModel.trackQuantity.value = value!;
                    }
                ),
                ),
                const Text(
                  'Track quantity',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Locations',
                  style: interNormalText,
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'Edit Locations',
                      style: interNormalText.copyWith(
                        fontWeight: FontWeight.w400,
                        color: newColorBlue
                      ),
                    )
                )
              ],
            )
          ],
        ),
      ),
    );
  }

}
