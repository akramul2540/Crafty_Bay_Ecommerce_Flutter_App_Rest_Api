class Urls{
  static const  String baseUrls = 'https://craftybay.teamrabbil.com/api';
  static const  String productSliderUrl = '$baseUrls/ListProductSlider';
  static const String categoryListUrl = '$baseUrls/CategoryList';
  static const String readProfileUrl = '$baseUrls/ReadProfile';
  static const String addToCartUrl = '$baseUrls/CreateCartList';
  static const String getCartListUrl = '$baseUrls/CartList';
  static const String createReviewListUrl = '$baseUrls/CreateProductReview';
  static const String productWishListUrl = '$baseUrls/ProductWishList';
  static const String createProfileUrl = '$baseUrls/CreateProfile';
  static const String readProfileDataUrl = '$baseUrls/ReadProfile';
  static String ProductListByRemarkUrl(String remark) => '$baseUrls/ListProductByRemark/$remark';
  static String ProductListByCategoryUrl(String categoryId) => '$baseUrls/ListProductByCategory/$categoryId';
  static String ProductDetailsByIdUrl(int productId) => '$baseUrls/ProductDetailsById/$productId';
  static String sendOtpToEmailUrl(String email) => '$baseUrls/UserLogin/$email';
  static String varifyOtpUrl(String email, String otp) => '$baseUrls/VerifyLogin/$email/$otp';
  static String deleteCartUrl(int cartId) => '$baseUrls/DeleteCartList/$cartId';
  static String productReviewUrl(int productId) => '$baseUrls/ListReviewByProduct/$productId';
  static String createWishListUrl (int productId) => '$baseUrls/CreateWishList/$productId';
}