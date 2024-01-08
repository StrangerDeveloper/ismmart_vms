import 'package:get/get.dart';
import 'package:ismmart_vms/helper/constants.dart';
import '../../helper/api_base_helper.dart';
import '../../helper/global_variables.dart';
import '../../helper/urls.dart';
import '../order_listing/model/orderModel.dart';
import '../order_listing/order_viewmodel.dart';
import 'order_detail_view.dart';
import 'order_detail_viewmodel.dart';

class CancelORderViewMOdel extends GetxController {

  OrderListingViewModel orderListingViewModel = Get.find();
  OrderDetailViewModel orderDetailViewModel = Get.find();

  RxBool selectAllValue = false.obs;
  Rx<OrderItem> orderItemModel = OrderItem().obs;
  RxList<Lineitem> lineItemList = <Lineitem>[].obs;
  RxList<Lineitem> selectedItems = <Lineitem>[].obs;

  RxList<Lineitem> unfulfilledItems = <Lineitem>[].obs;

  @override
  void onInit() {
    orderItemModel.value = Get.arguments['model'];
    lineItemList.addAll(orderItemModel.value.lineitems ?? []);
    unfulfilledItems.addAll(orderItemModel.value.lineitems
            ?.where((element) => element.fulfilmentStatus == "Unfulfilled")
            .toList() ??
        []);
    super.onInit();
  }

  Future<void> updateOrder() async {
    try {
      List<String> selectedIndicesId = [];
      String selectedItemsStatus = "";

      for (int i = 0; i < lineItemList.length; i++) {
        if (lineItemList[i].isSelected == true) {
          selectedIndicesId.add(lineItemList[i].sId!);
          selectedItemsStatus = lineItemList[i].fulfilmentStatus!;
        }
      }

      if (selectedItemsStatus == "Unfulfilled") {
        selectedItemsStatus = "Cancelled";

        Map<String, dynamic> param = {
          "itemsIndex": selectedIndicesId,
          "status": selectedItemsStatus,
        };
        await ApiBaseHelper()
            .putMethod(url: Urls.updateOrder, body: param)
            .then((response) async {
          if (response['success'] == true) {
            for (int i = 0; i < lineItemList.length; i++) {
              if (lineItemList[i].isSelected == true) {
                lineItemList[i].fulfilmentStatus = "Cancelled";
              }
            }
            orderDetailViewModel.orderItemModel.refresh();
            unfulfilledItems.clear();
            unfulfilledItems.refresh();
            selectedItems.clear();
            selectedItems.refresh();
            selectAllValue.value = false;
            GlobalVariable.showLoader.value = false;
            await orderListingViewModel.getOrderListing();

            Get.to(() => OrderDetailView());
          } else {
            AppConstant.displaySnackBar(
                'Error', 'Something went wrong, please try again');
          }
        });
      } else {
        AppConstant.displaySnackBar(
            'Error', 'You can not cancel fulfilled item');
      }
    } catch (error) {
      // print(error);
    }
  }

  selectAllItems() {
    selectAllValue.value = !selectAllValue.value;
    if (selectAllValue.value) {
      if (selectedItems.isEmpty) {
        for (int i = 0; i < (unfulfilledItems.length); i++) {
          Lineitem model = unfulfilledItems[i];
          model.isSelected = true;

          unfulfilledItems[i] = model;
          selectedItems.add(model);
        }
      } else {
        for (int i = 0; i < (unfulfilledItems.length); i++) {
          Lineitem model = unfulfilledItems[i];
          model.isSelected = true;
          unfulfilledItems[i] = model;
        }
        selectedItems.clear();
        selectedItems.addAll(unfulfilledItems);
      }
    } else {
      for (int i = 0; i < (unfulfilledItems.length); i++) {
        Lineitem model = unfulfilledItems[i];
        model.isSelected = false;
        unfulfilledItems[i] = model;
      }
      selectedItems.clear();
    }
  }

  selectSingleItem(bool value, int index) {
    Lineitem model = unfulfilledItems[index];
    model.isSelected = value;
    unfulfilledItems[index] = model;
  }

  @override
  void onClose() {
    GlobalVariable.showLoader.value = false;
    super.onClose();
  }
}
