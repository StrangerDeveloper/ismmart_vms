class Urls {
  //SignInViewModel
  static String baseUrl =
      "https://ismmart-ecommerce-backend-e233368b3b0d.herokuapp.com/api";

  // end users------------
  static String register = "/vendor/auth/register";
  // static String baseUrl = "https:///ismmart-ecommerce-backend-e233368b3b0d.herokuapp.com/api";
  static String getPayout = "/vendor/payout?limit=10&page=";
  static String getLocation = "/vendor/location?limit=10&page=";

  static String getOrder = "/vendor/order?limit=10&page=";
}
