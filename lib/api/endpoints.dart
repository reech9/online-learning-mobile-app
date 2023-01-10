// customer endpoints
class CustomerEndpoints {
  //auth
  static const String signup = "/verification/signup";
  static const String forget_password = "/user/passportReset";
  static const String signin = "/verification/login";
  static const String userDetails = "/user/details";
  static const String passwordReset = "/user/changePassword";
  static const String updateDetails = "/user/update-details";
  static const String changeDisplayPicture = "/user/update-display-picture";

  static const String categories = "/category";
  static const String courses = "/course";
  static const String courseDetail = "/course/details/";
  static const String lecturer = "/lecturer/";
  static const String courseAddLearner = "/course/addLearners/";
  static const String myLearnings = "/user/my-learnings/";
  static const String notification = "/notification";
  static const String markRead = "/notification/mark-as-read/";

  static const String myAchievement = "/achievement/certificate";
  static const String certificateAchievement = "/achievement/certificate/";
  static const String postAchievement = "/achievement/certificate/";



  static const String refreshToken = "/verification/refresh-token/";

  static const String lessonDetail = "/lesson/";
  static const String lessonStatus = "/lesson-status/";
  static const String comments = "/comment/";
  static const String commentReply = "/comment/reply/";
  static const String userRating = "/lesson-rating/user/";
  static const String userRatingUpdate = "/lesson-rating/";

  static const String wishlist = "/wishlist/";
  static const String wishlistRemove = "/wishlist/remove";

  static const String courseAssessment = "/assessment/course/";
  static const String lessonAssessment = "/assessment/";
  static const String submission = "/submission/";
  static const String routine = "/routine/";

  static const String getAllQuiz = "/quiz/";
  static const String postAnswers = "/quiz/answer/";
  static const String getScores = "/quiz/scores/";

  static const String topMenu = "/menu/detailforuser/top-menu";
  static const String homeSlider = "/slider/key/HomeSlider";
  static const String home = "/home";
  static const String trending = "/festive-offer/trending";
  static const String trendingRegistered = "/festive-offer/registered";
  static const String trendingEvents = "/festive-offer/events";
  static const String userProductGroup = "/productgroup/userproductgroup";
  // static const String viewCart = "/cart/item";
  static const String viewCartUpdate = "/cart/item";
  static const String cartInstant = "/cart/instant";

  //changed the cart route from old route to new route with cart id
  static const String paymentMethod = "/cart/payment";

  //reedem Cart with or without voucher
  static const String reedemStatus = "/reward/redeem-status";

  static const String viewCart = "/cart/item";
  static const String toGuest = "/cart/toguest";
  static const String shippingCharge = "/cart/shipping/charge";
  static const String cartShipping = "/cart/shipping";
  static const String relatedProduct = "/product/product/relatedproduct/";
  static const String productBySeller = "/product/seller/";
  static const String justForYou = "/product/popular";
  static const String singleProduct = "/product/";
  static const String producyByCategory = "/product/category/";
  static const String categoryBanner = "/category-banner/category/";
  static const String gCash = "/reward/balance/";
  static const String redeemAmount = "/reward/redeemable-amount";
  static const String rewardPoints = "/cart/item/reward-points";
  static const String coupon = "/cart/item/coupon";
  static const String gCashHistory = "/reward?&find_type=active";
  static const String favourite = "/favourite/myfav/";
  static const String updateFavourite = "/favourite/";
  static const String userProfile = "/user/profile/";
  static const String userLoyalty = "/user/loyalty";
  static const String userVerify = "/user/mobile/";
  static const String userVerifyOtp = "/user/mobile/verify";
  static const String userVerifyEmail = "/user/verifymail";
  static const String userForgetPassword = "/user/forgotpassword";
  static const String userResetPassword = "/user/resetpassword";

  // get params search
  static const String quickSearch = "/course/search?search=";
  // normal params search
  static const String search = "/elastic/search";
  static const String searchBrand = "/search";

  static const String categoryEnquiry = "/product";

  static const String productByCategory = "/product/productbycategory/";
  static const String productReview = "/reviewProduct/productdetail/";
  static const String productReviewCount = "/reviewProduct/";

  static const String nepalAll = "/static/nepal/all";
  static const String billingAddress = "/billingshipping?&find_type=active";
  static const String billingShipping = "/billingshipping";

  static const String orders = "/cart/buyer/order";
  static const String ordersCancel = "/cart/buyer/order/cancel";

  static const String orderDetail = "/cart/buyer/order/details";
  static const String reviewProduct = "/reviewProduct";

  static const String marketRepresentative = "/user/profile/mr/detail";
  // NOTIFICAIONS

  static const String notificationUser = "/notification/user/";
  static const String notificationCount = "/notification/count/new";
  static const String jackpotData = "/flash-deal-product/trending";
  static const String notificationSeenAll = "/notification/seen";

  // WEBVIEW URL
  static const String termsAndCondition = "/contents/key/term-and-condition";
  static const String companyInfo = "/contents/key/company-info";
  static const String contactDetail = "/contents/key/contactdetail";
  static const String contact = "/contact";

  static const String dataPolicy = "/contents/key/data-policy";
  static const String cookiesPolicy = "/contents/key/cookies-policy";
  static const String refundPolicy = "/contents/key/refund-policy";
  static const String returnPolicy = "/contents/key/return-policy";
  static const String gCashPolicy = "/contents/key/gcashpolicy";

  //PROFILE URL
  static const String editprofile = '/user/profile/';
  static const String logout = '/user/logout';
  static const String changepassword = '/user/changepassword';

  //Payment
  static const String paymentConfirm = "/cart/payment/conform?is_mobile=true";
  static const String paymentKhalti = "/cart/payment/khalti";
  static const String paymentEsewa = "/cart/payment/mobile/esewa";
  static const String paymentImePay = "/cart/payment/imepay/mobile/success";

  static const String fonePay = "/cart/payment/fonepay";
  static const String nicAsia = "/cart/payment/nic-asia";
  static const String hbl = "/cart/payment/hbl";
  static const String imePayWeb = "/cart/payment/imepay";
  static const String cellPayWeb = "/cart/payment/cellpay";
  static const String prabhuPayWeb = "/cart/payment/prabhu-pay";

  static const String paymenyCellPay = "/cart/payment/cellpay/success";
  // static const String prabhuPay = "/cart/payment/prabhupay/mobile/success";
  static const String prabhuPay = "/cart/payment/prabhupay/mobile/conform";

  static const String shareUrl = "/share/generate-link";



  static const String testGetCourse = "/course";
}
