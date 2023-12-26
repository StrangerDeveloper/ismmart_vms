import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/screens/add_product/add_product_1/add_product_1_view.dart';
import 'package:ismmart_vms/screens/add_product/add_product_2/add_product_2_viewmodel.dart';
import 'package:ismmart_vms/widgets/custom_button.dart';

import '../../../helper/constants.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/widget_models/variant_options_field_model.dart';
import '../add_product_3/add_product_3_view.dart';

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
              // stepperText(),
              variantsContainer(context),
              inventoryContainer(),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 5),
                child: CustomTextBtn(
                  title: 'Save & Next',
                  onPressed: () {
                    Get.to(() => AddProduct3View());
                  },
                ),
              ),
              CustomTextBtn(
                title: 'Back',
                backgroundColor: Colors.black,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
          onPressed: () => Get.to(() => AddProduct1View()),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 22,
            color: newColorLightGrey2,
          )),
      title: Text(
        'Add Product',
        style: dmSerifDisplay1.copyWith(fontSize: 20),
      ),
      centerTitle: true,
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
            Obx(() {
              return Column(
                children: List.generate(
                  viewModel.listOfOptionsAdded.length,
                  (index) {
                    final option = viewModel.listOfOptionsAdded[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          option.optionName ?? '',
                          style: interNormalText,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(
                            option.optionValues?.length ?? 0,
                            (idx) {
                              final valueController = option.optionValues?[idx];
                              return Container(
                                color: Colors.grey.shade100,
                                child: Text(
                                  valueController?.text ?? '',
                                  style: interNormalText.copyWith(
                                    color: Colors.grey,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(),
                        Column(
                          children: List.generate(
                            option.optionValues?.length ?? 0,
                            (idx) {
                              final valueController = option.optionValues?[idx];
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        valueController?.text ?? '',
                                        style: interNormalText,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Rs 0.00',
                                        style: interNormalText.copyWith(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        '0 available at 5 locations',
                                        style: interNormalText.copyWith(
                                          color: Colors.grey,
                                        ),
                                      )
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // viewModel.listOfOptionsAdded.removeWhere(
                                      //     (element) => element == option);
                                      // viewModel.listOfOptionsAdded.refresh();
                                    },
                                    child: const Text(
                                      'Edit',
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        )
                      ],
                    );
                  },
                ),
              );
            }),
            variantAdditionField(context),
          ],
        ),
      ),
    );
  }

  // Widget variantsContainer(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 10.0),
  //     child: Container(
  //       padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
  //       decoration: textContainerDecoration,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             'Variants',
  //             style: interHeadingSize14,
  //           ),
  //           variantAdditionField(context)
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget variantAdditionField(BuildContext context) {
    return Obx(
      () => viewModel.showVariantsField.value
          ? const Column(
              children: [SizedBox()],
            )
          : TextButton(
              onPressed: () async {
                viewModel.listOfOptionsAdded.add(VariantsOptionsFieldModel(
                    optionName: '', optionValues: [TextEditingController()]));
                await variantSelectionDialog();
              },
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '+ Add options like color or size',
                  style: interNormalText.copyWith(
                      color: newColorBlue, fontSize: 12),
                ),
              ),
            ),
    );
  }

  Future variantSelectionDialog() {
    return showModalBottomSheet(
        context: Get.context!,
        isScrollControlled: false,
        backgroundColor: Colors.white,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: viewModel.variantsFormKey,
              child: SingleChildScrollView(
                controller: viewModel.scrollController,
                physics: const ScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            'Variants',
                            //style: interHeadingSize14.copyWith(color: newColorBlue)
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
                          icon: const Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    Obx(
                      () => Column(
                        children: viewModel.listOfOptionsAdded.map((e1) {
                          print(viewModel.listOfOptionsAdded.length);
                          TextEditingController optionName =
                              TextEditingController();
                          optionName.text = e1.optionName!;
                          return Column(
                            children: [
                              CustomTextField2(
                                title: 'Option Name',
                                hintText: 'Name your variant',
                                controller: optionName,
                                onChanged: (value) {
                                  e1.optionName = value;
                                  viewModel.listOfOptionsAdded.refresh();
                                },
                                validator: (value) {
                                  if (value == null ||
                                      value == "" ||
                                      value.isEmpty) {
                                    return 'Enter name for variant';
                                  } else {
                                    return null;
                                  }
                                },
                                onTap: () {
                                  if (viewModel.listOfOptionsAdded.length ==
                                      1) {
                                    viewModel.listOfOptionsAdded.clear();
                                    viewModel.listOfOptionsAdded.refresh();
                                    Get.back();
                                  } else {
                                    viewModel.listOfOptionsAdded.removeWhere(
                                        (element) => element == e1);
                                    viewModel.listOfOptionsAdded.refresh();
                                  }
                                },
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Divider(
                                  thickness: 0.8,
                                  color: kLightColor,
                                ),
                              ),
                              Obx(() => viewModel.listOfOptionsAdded.isEmpty
                                  ? const SizedBox()
                                  : Column(
                                      children: e1.optionValues!.map((e2) {
                                        TextEditingController optionController =
                                            e2;
                                        String? title;
                                        if (optionController ==
                                            e1.optionValues?.first) {
                                          title = 'Option Values';
                                        }
                                        if (e2 == e1.optionValues!.last) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomTextField2(
                                                  hintText: 'Add value',
                                                  title: title,
                                                  onChanged: (value) {
                                                    optionController.text =
                                                        value;
                                                  },
                                                  onTap: () {
                                                    if (e1.optionValues
                                                            ?.length ==
                                                        1) {
                                                      viewModel
                                                          .listOfOptionsAdded
                                                          .removeWhere(
                                                              (element) =>
                                                                  element ==
                                                                  e1);
                                                      viewModel
                                                          .listOfOptionsAdded
                                                          .refresh();
                                                      if (viewModel
                                                          .listOfOptionsAdded
                                                          .isEmpty) {
                                                        Get.back();
                                                      }
                                                    } else {
                                                      e1.optionValues
                                                          ?.removeWhere(
                                                              (element) =>
                                                                  element ==
                                                                  e2);
                                                      viewModel
                                                          .listOfOptionsAdded
                                                          .refresh();
                                                    }
                                                  },
                                                ),
                                                TextButton(
                                                    onPressed: () {
                                                      if (optionController
                                                                  .text ==
                                                              "" ||
                                                          optionController
                                                              .text.isEmpty) {
                                                        AppConstant.displaySnackBar(
                                                            'Error',
                                                            'Enter Value to add more fields');
                                                      } else {
                                                        e1.optionValues?.add(
                                                            TextEditingController());
                                                        viewModel
                                                            .listOfOptionsAdded
                                                            .refresh();
                                                      }
                                                    },
                                                    child: const Text(
                                                      'Add another value',
                                                      //style: interNormalText.copyWith(color: newColorBlue),
                                                    ))
                                              ],
                                            ),
                                          );
                                        } else {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomTextField2(
                                                  hintText: 'Add value',
                                                  title: title,
                                                  onChanged: (value) {
                                                    optionController.text =
                                                        value;
                                                  },
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value == '' ||
                                                        value.isEmpty) {
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
                                      }).toList(),
                                    )),
                              e1 == viewModel.listOfOptionsAdded.last
                                  ? const SizedBox()
                                  : const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8),
                                      child: Divider(
                                        thickness: 1.3,
                                        color: Colors.black,
                                      ),
                                    ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        viewModel.listOfOptionsAdded.add(
                            VariantsOptionsFieldModel(
                                optionName: '',
                                optionValues: [TextEditingController()]));
                      },
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '+ Add another Option',
                        ),
                      ),
                    ),
                    CustomRoundedTextBtn(
                      onPressed: () {
                        if (viewModel.variantsFormKey.currentState!
                            .validate()) {
                          Get.back();
                        }
                      },
                      title: 'Done',
                      borderRadius: 8,
                      backgroundColor: newColorBlue,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
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
              dropdownList: viewModel.locationsList),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_horiz_rounded,
                  size: 20,
                  color: Colors.black,
                )),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: viewModel.finalCombinationsList.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Checkbox(
                    value:
                        viewModel.finalCombinationsList[index].variantSelected,
                    onChanged: (value) {
                      viewModel.finalCombinationsList[index].variantSelected =
                          value;
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
                        fontWeight: FontWeight.w400),
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
            Obx(
              () => _checkBox(
                'Track quantity',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Quantity',
                  style: interNormalText,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Edit Locations',
                    style: interNormalText.copyWith(
                        fontWeight: FontWeight.w400, color: newColorBlue),
                  ),
                )
              ],
            ),
            const Divider(),
            _buildField2('Warehouse_1'),
            const SizedBox(
              height: 10,
            ),
            _buildField2('Warehouse_2'),
            const SizedBox(
              height: 10,
            ),
            _buildField2('Warehouse_3'),
            const SizedBox(
              height: 10,
            ),
            Obx(
              () => _checkBox(
                'Continue selling when out of stock',
              ),
            ),
            Obx(
              () => _checkBox(
                "This product has a SKU or barcode",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            hsCodeTxtField('SKU (Stock Keeping Unit)'),
            const SizedBox(
              height: 10,
            ),
            hsCodeTxtField('Barcode (ISBN, UPC, GTIN, etc.)'),
          ],
        ),
      ),
    );
  }

  Widget _checkBox(text) {
    return Row(
      children: [
        Checkbox(
            side: const BorderSide(color: newColorBlue),
            fillColor: viewModel.trackQuantity.value
                ? MaterialStateColor.resolveWith((states) => newColorBlue)
                : MaterialStateColor.resolveWith((states) => Colors.white),
            checkColor: Colors.white,
            value: viewModel.trackQuantity.value,
            onChanged: (value) {
              viewModel.trackQuantity.value = value!;
            }),
        Text(
          text,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
        )
      ],
    );
  }

  Widget hsCodeTxtField(String title) {
    return CustomTextField5(
      title: title,
      //hintText: 'Search by product keyword or code',
    );
  }

  Widget _buildField2(String var1) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Warehouse_1',
          style: interNormalText,
        ),
        const SizedBox(
          width: 15,
        ),
        const Expanded(
          child: CustomTextField5(
            hintText: '0',
            suffixIcon: Icons.unfold_more,
          ),
        )
      ],
    );
  }
}
