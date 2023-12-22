import 'package:get/get.dart';
import 'package:ismmart_vms/widgets/widget_models/dropdown_model.dart';

class AddLocationViewModel extends GetxController{
  RxString statusValue = '1'.obs;
  List<DropDownModel> statusList = <DropDownModel>[
    DropDownModel(id: '1', name: 'Account No'),
    DropDownModel(id: '2', name: 'IBAN'),
  ].obs;


}