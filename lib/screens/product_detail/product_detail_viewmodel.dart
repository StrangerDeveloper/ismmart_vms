import 'package:get/get.dart';

import '../../widgets/widget_models/dropdown_model.dart';

class ProductDetailViewModel extends GetxController {
  RxBool selectAllValue = false.obs;
  List<MultiSelectModel> dataList = <MultiSelectModel>[
    MultiSelectModel(id: '1', name: 'hello'),
    MultiSelectModel(id: '2', name: 'hayat'),
    MultiSelectModel(id: '3', name: 'how are you'),
    MultiSelectModel(id: '4', name: 'how are you'),
    MultiSelectModel(id: '5', name: 'how are ysad'),
    MultiSelectModel(id: '6', name: 'how are yasdsda'),
  ].obs;

  selectSingleItem(bool value, int index) {
    MultiSelectModel model1 = dataList[index];
    model1.isSelected = value;
    dataList[index] = model1;
  }

  selectAllItems() {
    selectAllValue.value = !selectAllValue.value;

    for (int i = 0; i < dataList.length; i++) {
      MultiSelectModel model1 = dataList[i];
      model1.isSelected = selectAllValue.value;
      dataList[i] = model1;
    }
  }
}
