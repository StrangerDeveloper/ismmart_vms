import 'package:get/get.dart';
import 'package:ismmart_vms/screens/forgot_password/forgot_password_view.dart';

import '../screens/auth/login/login_view.dart';
import '../screens/dashboard/dashboard_view.dart';
import '../screens/order_listing/order_view.dart';
import '../screens/splashscreen/splasch_screen_view.dart';

class Routes {
  static const initRoute = "/";
  static const onBoard = "/onBoard";
  static const bottomNavigation = "/bottomNavigation";
  static const shopifyWebView = "/shopifyWebView";
  static const addProduct = "/addProduct";
  static const addProductCategoryFields = "/addProductCategoryFields";
  static const allDispute = "/allDispute";
  static const buyerOrdersRoute = "/buyerOrders";
  static const buyerProfile = "/buyerProfile";
  static const updateBuyerProfile = "/updateBuyerProfile";
  static const cartRoute = "/cart";
  static const categories = "/categories";
  static const changeAddressRoute = "/changeAddress";
  static const addUpdateAddress = "/addUpdateAddress";
  static const changePassword = "/changePassword";
  static const checkOutRoute = "/checkout";
  static const contactUs = "/contactUs";
  static const dashboard = "/dashboard";
  static const chatScreen = "/chatScreen";
  static const disputeDetail = "/disputeDetail";
  static const emailVerificationLinkRoute = "/emailVerificationLink";
  static const emailVerified = "/api/auth/verifyEmail";
  static const faq = "/faq";
  static const forgotPassword1 = "/forgotPassword1";
  static const forgotPassword2 = "/forgotPassword2";
  static const staticInfo = "/staticInfo";
  static const myProduct = "/myProduct";
  static const productQuestions = "/productQuestions";
  static const searchRoute = "/searchView";
  static const searchDetails = "/searchDetailsView";
  static const sellerHomeRoute = "/sellerDash";
  static const settings = "/settings";
  static const loginRoute = "/signIn";
  static const vendorSignUp1 = "/vendorSignUp1";
  static const vendorSignUp2 = "/vendorSignUp2";
  static const vendorSignUp3 = "/vendorSignUp3";
  static const vendorSignUp4 = "/vendorSignUp4";
  static const registerRoute = "/register";
  static const updateProduct = "/updateProduct";
  static const updateVendor = "/updateVendor";
  static const vendorDetail = "/vendorDetail";
  static const vendorOrders = "/vendorOrders";
  static const vendorQuestion = "/vendorQuestion";
  static const chooseEmail = "/chooseEmail";
  //static const singleProductDetails = "/singleProductDetails";
  static const singleProductFullImage = "/singleProductFullImage";

  //static const aboutUsRoute = "/aboutUs";
  ///Pages with passing :ID
  // static const productDetailsRoute = "/product/:id";
  static const orderDetailsRoute = "/orderDetails/:id";
  static const storeDetailsRoute = "/storeDetails/:id";
  static const orderRoute = "/order";

  static final pages = [
    GetPage(
      name: initRoute,
      page: () => SplashScreenView(),
      //binding: BaseBindings(),
    ),
    // GetPage(
    //   name: onBoard,
    //   page: () => OnBoardView(),
    //   //binding: BaseBindings(),
    // ),
    // GetPage(
    //   name: shopifyWebView,
    //   page: () => ShopifyWebView(),
    //   //binding: BaseBindings(),
    // ),
    // GetPage(
    //   name: bottomNavigation,
    //   page: () => const BottomNavigationView(),
    //   binding: BaseBindings(),
    // ),
    // GetPage(
    //   name: emailVerified,
    //   page: () => const EmailVerifedView(),
    //   binding: BaseBindings(),
    // ),
    // GetPage(
    //   name: addProduct,
    //   page: () => AddProductView(),
    // ),

    // // GetPage(
    // //   name: addProductCategoryFields,
    // //   page: () => AddProductCategoryFieldsView(),
    // // ),
    // GetPage(
    //   name: allDispute,
    //   page: () => AllDisputeView(),
    // ),
    // GetPage(
    //   name: buyerOrdersRoute,
    //   page: () => BuyerOrderView(),
    //   binding: OrdersBindings(),
    // ),
    // GetPage(
    //   name: buyerProfile,
    //   page: () => BuyerProfileView(),
    // ),
    // GetPage(
    //   name: updateBuyerProfile,
    //   page: () => UpdateBuyerProfileView(),
    // ),
    // GetPage(
    //   name: cartRoute,
    //   page: () => CartView(),
    //   binding: BaseBindings(),
    // ),
    // GetPage(
    //   name: categories,
    //   page: () => CategoriesView(),
    //   binding: BaseBindings(),
    // ),
    // GetPage(
    //   name: changeAddressRoute,
    //   page: () => ChangeAddressView(),
    //   binding: CheckoutBinding(),
    //   middlewares: [AuthMiddleWare(priority: 1)],
    // ),
    // GetPage(
    //   name: addUpdateAddress,
    //   page: () => AddUpdateAddressView(),
    // ),
    // GetPage(
    //   name: changePassword,
    //   page: () => ChangePasswordView(),
    // ),
    // GetPage(
    //   name: checkOutRoute,
    //   page: () => CheckoutView(),
    //   binding: CheckoutBinding(),
    //   middlewares: [AuthMiddleWare(priority: 5)],
    // ),
    // GetPage(
    //   name: contactUs,
    //   page: () => ContactUsView(),
    // ),
    GetPage(
      name: dashboard,
      page: () => DashboardView(),
    ),
    // GetPage(
    //   name: chatScreen,
    //   page: () => ChatBotView(),
    // ),
    // GetPage(
    //   name: disputeDetail,
    //   page: () => DisputeDetailView(),
    // ),
    // GetPage(
    //   name: emailVerificationLinkRoute,
    //   page: () => EmailVerificationView(),
    //   binding: BaseBindings(),
    // ),
    // GetPage(
    //   name: faq,
    //   page: () => FaqView(),
    // ),
    GetPage(
      name: forgotPassword1,
      page: () => ForgotPasswordView(),
    ),
    // GetPage(
    //   name: forgotPassword2,
    //   page: () => VerifyPasswordView(),
    // ),
    // GetPage(
    //   name: staticInfo,
    //   page: () => StaticInfoView(),
    // ),
    // GetPage(
    //   name: myProduct,
    //   page: () => MyProductView(),
    // ),
    // GetPage(
    //   name: productQuestions,
    //   page: () => ProductQuestionsView(),
    // ),
    // GetPage(
    //   name: searchRoute,
    //   page: () => SearchView(),
    //   //binding: SearchBindings(),
    //   bindings: [
    //     SearchBindings(),
    //   ],
    // ),
    // GetPage(
    //   name: singleProductFullImage,
    //   page: () => SingleProductFullImageView(),
    // ),
    // GetPage(
    //   name: searchDetails,
    //   page: () => SearchDetailsView(),
    //   //binding: SearchBindings(),
    //   bindings: [SearchBindings(), ProductBinding()],
    // ),

    // GetPage(
    //   name: sellerHomeRoute,
    //   page: () => const SellerHomeView(),
    //   binding: SellerBindings(),
    // ),
    // GetPage(
    //   name: settings,
    //   page: () => SettingsView(),
    // ),
    // GetPage(
    //   name: loginRoute,
    //   page: () => LogInView(),
    //   binding: BaseBindings(),
    // ),
    // GetPage(
    //   name: registerRoute,
    //   page: () => SignUpView(),
    //   binding: BaseBindings(),
    // ),
    // GetPage(
    //   name: updateProduct,
    //   page: () => UpdateProductView(),
    // ),
    // GetPage(
    //   name: updateVendor,
    //   page: () => UpdateVendorProfileView(),
    // ),
    // GetPage(
    //   name: vendorDetail,
    //   page: () => VendorProfileView(),
    // ),
    // GetPage(
    //   name: vendorSignUp1,
    //   page: () => VendorSignUp1View(),
    // ),
    // GetPage(
    //   name: vendorSignUp2,
    //   page: () => VendorSignUp2View(),
    // ),
    // GetPage(
    //   name: vendorSignUp3,
    //   page: () => VendorSignUp3View(),
    // ),
    // GetPage(
    //   name: vendorSignUp4,
    //   page: () => VendorSignUp4View(),
    // ),
    // GetPage(
    //   name: chooseEmail,
    //   page: () => ChooseEmail(),
    // ),
    // GetPage(
    //   name: vendorOrders,
    //   page: () => VendorOrdersView(),
    // ),
    // GetPage(
    //   name: vendorQuestion,
    //   page: () => VendorQuestionView(),
    // ),
    // /////////////////////////////////////////////////////////////////////////
    // GetPage(
    //     name: sellerHomeRoute,
    //     page: () => const SellerHomeView(),
    //     binding: SellerBindings()),
    // // GetPage(
    // //   name: singleProductDetails,
    // //   page: () => SingleProductDetailsView(),
    // // ),
    // GetPage(
    //   name: '/orderDetails/:id',
    //   page: () => const SingleOrderDetailsUI(),
    //   binding: OrdersBindings(),
    // ),
    // GetPage(
    //   name: '/storeDetails/:storeId',
    //   page: () => const SellerStoreDetailView(),
    //   binding: ProductBinding(),
    // )
    GetPage(
      name: orderRoute,
      page: () => OrderView(),
    ),
  ];
}
