import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomSheet1 {
  final List<dynamic> list;
  final int selectedIndex;
  final void Function(int) onChanged;

  CustomBottomSheet1({
    required this.list,
    required this.selectedIndex,
    required this.onChanged,
  });

  show() {
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
                    initialItem: selectedIndex,
                  ),
                  itemExtent: 35,
                  onSelectedItemChanged: (int index) {
                    tempIndex = index;
                  },
                  children: List.generate(
                    list.length,
                    (int index) {
                      return Center(
                        child: Text(
                          list[index],
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
