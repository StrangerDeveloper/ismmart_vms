import 'package:get/get.dart';

class GlobalVariable {
  // static String token =
  //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2NTc4MDlkNjYzNTM0ZTNmY2ZiMTljNzIiLCJuYW1lIjoiVmVuZG9yIFJlZ2lzdHJhdGlvbiIsImlhdCI6MTcwMjM3NTgyMSwiZXhwIjoxNzA0OTY3ODIxfQ.tAKbb_OOrAq4kULjD2DiQYYTrD7YnHaAQqwZ1EhyjFo';
  static String token = "";
  static RxBool showLoader = false.obs;
  static RxBool noInternet = false.obs;
  static RxInt selectedIndex = 0.obs;
}
