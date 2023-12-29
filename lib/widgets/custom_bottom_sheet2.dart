import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/screens/add_product/add_product_1/model/category_model.dart';
import 'package:ismmart_vms/screens/add_product/add_product_1/model/types_model.dart';

class CustomBottomSheet2 {
  final List<CategoryItem>? categoryList;
  final List<TypesItem>? typeList;
  final int selectedIndex;
  final void Function(int) onChanged;

  CustomBottomSheet2({
    this.categoryList,
    this.typeList,
    required this.selectedIndex,
    required this.onChanged,
  });

  show() {
    int tempIndex = 0;
    showModalBottomSheet(
      context: Get.context!,
      builder: (BuildContext context) {
        return Container(
          height: 250,
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
                    initialItem: selectedIndex,
                  ),
                  itemExtent: 40,
                  onSelectedItemChanged: (int index) {
                    tempIndex = index;
                  },
                  children: List.generate(
                    (categoryList ?? typeList ?? []).length,
                    (int index) {
                      return Center(
                        child: Text(
                          categoryList != null
                              ? categoryList![index].name!
                              : typeList != null
                                  ? typeList![index].name!
                                  : '',
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
                onPressed: () {
                  onChanged(tempIndex);
                  Get.back();
                },
                child: const Text(
                  'Done',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
