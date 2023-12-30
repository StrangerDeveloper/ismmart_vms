import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBankViewModel extends GetxController {
  bool isEdit = false;
  GlobalKey<FormState> addBankFormKey = GlobalKey<FormState>();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cardHolderNameController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  RxString bankName = 'Meezan Bank'.obs;
  RxString cardHolder = 'Card Holder'.obs;
  RxString cardNumber = '0000 0000 0000 0000'.obs;
}
