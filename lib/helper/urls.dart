class Urls {
  //SignInViewModel
  static String baseUrl =
      "https://ismmart-ecommerce-backend-e233368b3b0d.herokuapp.com/api";

  // end users------------
  static String register = "/vendor/auth/register";
  static String login = "/vendor/auth/login";
  // static String baseUrl = "https:///ismmart-ecommerce-backend-e233368b3b0d.herokuapp.com/api";
  // static String getPayout = "/vendor/payout";
  static String country = "/places/countries?limit=0&sort[name]=1";
  static String city = "/places/cities?country=";
  static String bank = "/vendor/bank";
  static String storeType = "/public/storeType";
  static String getPayout = "/vendor/payout?limit=10&page=";
  static String getLocation = "/vendor/location?limit=10&page=";
  static String getInventoryLocation = '/vendor/location';
  static String getCities = "/places/cities?limit=0&country=";
  static String getCountries = "/places/countries?limit=0";
  static String addLocation = "/vendor/location/add";
  static String updateLocation = "/vendor/location/update/";
  static String getOrders = "/vendor/order";
  static String getUserData = "/auth/profile";
  static String updateUserData = "/vendor/auth/update";
  static String getStoreType = "/public/storeType";
  static String collection = "/public/collection";
  static String getBank = "/vendor/bank";
  static String deleteBank = "/vendor/bank/delete/";
  static String addBank = "/vendor/bank/add";
  static String updateBank = "/vendor/bank/update/";
  static String forgetPassword = "/auth/forgot";
  static String updateOrder = "/vendor/order/update/status";
  static String resendEmail = "/vendor/auth/resend";
  static String addProduct = "/vendor/product/add";

  ///Dashboard
  static String getProductSummary = "/vendor/dashboard/summary/product?duration=";
  static String getOrderSummary = "/vendor/dashboard/summary/order?duration=";
  static String getOrderStatusSummary = "/vendor/dashboard/summary/order/status?duration=";
  static String getRevenuSummary = "/vendor/dashboard/summary/revenue?duration=";
}
