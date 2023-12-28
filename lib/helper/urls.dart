class Urls {
  //SignInViewModel
  static String baseUrl =
      "https://ismmart-ecommerce-backend-e233368b3b0d.herokuapp.com/api";

  // end users------------
  static String register = "/vendor/auth/register";
  static String login = "/vendor/auth/login";
  // static String baseUrl = "https:///ismmart-ecommerce-backend-e233368b3b0d.herokuapp.com/api";
  static String getPayout = "/vendor/payout";
  static String country = "/places/countries?limit=0";
  static String city = "/places/cities?country=";
  static String bank = "/vendor/bank";
  static String storeType = "/public/storeType";
}
