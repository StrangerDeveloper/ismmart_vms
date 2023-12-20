import 'package:get/get.dart';
import 'package:ismmart_vms/screens/return/model.dart';

class ReturnViewModel extends GetxController {
  var returnModel = ReturnModel().obs;
  RxList<ReturnModel> returnItemList = <ReturnModel>[].obs;
  RxList<int> selectedItemList = <int>[].obs;

  addReturnItemList() {
    returnModel.value.isSelected;
    returnItemList.add(ReturnModel(
        id: 1,
        name: "item1",
        description: "discription",
        quantity: 3,
        color: "black",
        price: "3424",
        isSelected: false));

    returnItemList.add(ReturnModel(
        id: 2,
        name: "item2",
        description: "discription",
        quantity: 3,
        color: "green",
        price: "3424",
        isSelected: false));
    returnItemList.add(ReturnModel(
        id: 3,
        name: "item3",
        description: "discription",
        quantity: 7,
        color: "yellow",
        price: "3424",
        isSelected: false));

    returnItemList.add(ReturnModel(
        id: 4,
        name: "item4",
        description: "discription",
        quantity: 30,
        color: "white",
        price: "3424",
        isSelected: false));
  }

  isCheckedFu(int index, bool val) {
    returnItemList[index].isSelected = val;
    print(
        "=====index $index  value = $val    model ${returnItemList[index].isSelected}");
  }

  @override
  void onReady() {
    addReturnItemList();
    // TODO: implement onReady
    super.onReady();
  }
}
