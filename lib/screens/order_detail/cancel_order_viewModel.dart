import 'package:get/get.dart';
import 'package:ismmart_vms/helper/constants.dart';
import 'package:ismmart_vms/helper/languages/translations_key.dart';
import 'package:ismmart_vms/screens/order_detail/order_detail_viewModel.dart';

import '../../helper/api_base_helper.dart';
import '../../helper/urls.dart';
import '../order_listing/model/orderModel.dart';
import '../order_listing/order_viewModel.dart';

class CancelORderViewMOdel extends GetxController {
  OrderListingViewModel orderListingViewModel = Get.find();
  OrderDetailViewModel orderDetailViewModel = Get.find();

  RxBool selectAllValue = false.obs;
  Rx<OrderItem> orderItemModel = OrderItem().obs;
  RxList<Lineitem> lineItemList = <Lineitem>[].obs;
  RxList<Lineitem> selectedItems = <Lineitem>[].obs;

  @override
  void onInit() {
    orderItemModel.value = Get.arguments['model'];
    lineItemList.addAll(orderItemModel.value.lineitems ?? []);
    lineItemList.forEach((element) {
      print("Status ${element.sId}");
    });
    super.onInit();
  }

  Future<void> updateOrder() async {
    try {
      //use put method for update
      List<String> selectedIndicesId = [];
      String selectedItemsStatus = "";

      // Extract the indices of selected items
      for (int i = 0; i < lineItemList.length; i++) {
        if (lineItemList[i].isSelected == true) {
          selectedIndicesId.add(lineItemList[i].sId!);
          selectedItemsStatus = lineItemList[i].fulfilmentStatus!;
        }
      }

      if (selectedItemsStatus == "Unfulfilled") {
        //if unfulfilled then convert it into cancelled status and update the status
        selectedItemsStatus = "Cancelled";

        print("Fulfillment Statusss $selectedItemsStatus");
        Map<String, dynamic> param = {
          "itemsIndex": selectedIndicesId,
          "status": selectedItemsStatus,
        };
        await ApiBaseHelper()
            .putMethod(url: Urls.updateOrder, body: param)
            .then((response) async {
          if (response['success'] == true) {
            print("Statusss ${response['success']}");
            orderListingViewModel.orderItemList.clear();
            orderListingViewModel.orderItemList.refresh();
            orderListingViewModel.orderItemModel.value.items!.clear();
            orderDetailViewModel.lineItemList.clear();
            orderDetailViewModel.lineItemList.refresh();
            orderDetailViewModel.orderItemModel.value.lineitems!.clear();
            orderDetailViewModel.orderItemModel.refresh();

            await orderListingViewModel.getOrderListing();
            //show loeader while updating the status of order item and then gp back to the order detail screen
            Get.back();
          } else {
            AppConstant.displaySnackBar(
                'Error', 'Something went wrong, please try again');
          }
        });
      } else {
        //if fulfilled then show the alert
        AppConstant.displaySnackBar(
            'Error', 'You can not cancel fulfilled item');
      }
    } catch (error) {
      print(error);
    }
  }

  selectAllItems() {
    selectAllValue.value = !selectAllValue.value;
    if (selectAllValue.value) {
      if (selectedItems.isEmpty) {
        for (int i = 0; i < (lineItemList.length); i++) {
          Lineitem model = lineItemList[i];
          model.isSelected = true;

          lineItemList[i] = model;
          selectedItems.add(model);
        }
      } else {
        for (int i = 0; i < (lineItemList.length); i++) {
          Lineitem model = lineItemList[i];
          model.isSelected = true;
          lineItemList[i] = model;
        }
        selectedItems.clear();
        selectedItems.addAll(lineItemList);
      }
    } else {
      for (int i = 0; i < (lineItemList.length); i++) {
        Lineitem model = lineItemList[i];
        model.isSelected = false;
        lineItemList[i] = model;
      }
      selectedItems.clear();
    }
  }

  selectSingleItem(bool value, int index) {
    Lineitem model = lineItemList[index];
    model.isSelected = value;
    lineItemList[index] = model;
  }
}
