import 'package:get/get.dart';
import 'package:ismmart_vms/widgets/widget_models/dropdown_model.dart';

class AddAddressViewModel extends GetxController{
  RxString transferMethodValue = '1'.obs;
  List<DropDownModel> transferMethodList = <DropDownModel>[
    DropDownModel(id: '1', name: 'Account No'),
    DropDownModel(id: '2', name: 'IBAN'),
  ].obs;


}