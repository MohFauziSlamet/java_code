class ApiConst {
  ApiConst._();

  /// JAVA CODE BASE URL
  /// https://trainee.landa.id/javacode/
  static const String baseURL = 'http://trainee.landa.id/javacode/';
  static const String defaultToken = '5a714638b0c506c31845e3163089f6a0ed376b0e';

  /// POST LOGIN
  static const String postLoginURL = 'auth/login';

  /// GET ALL MENU
  static const String getAllMenuURL = 'menu/all';
  static const String getMenuMakananURL = 'menu/kategori/makanan';
  static const String getMenuMinumanURL = 'menu/kategori/minuman';
  static const String getMenuSnackURL = 'menu/kategori/snack';
  static const String detailMenuURL = 'menu/detail/';
  static const String getAllPromo = 'promo/all';
  static const String getDetailPromo = 'promo/detail/';
  static const String postLoginWithGoogle = 'auth/login';
  static const String postOrderMenu = 'order/add';
  static const String getDiskonByIdUser = 'diskon/user/';
  static const String getVoucheByIdUser = 'voucher/user/';
  static const String getDetailOrderByIdStruk = 'order/detail/';
  static const String getOrderByIdUser = 'order/user/';
  static const String postOrderByIdUser = 'order/history/';
  static const String getUserDetail = 'user/detail/';
  static const String postUpdateProfile = "user/profil/";
  static const String postUpdateUser = "user/update/";
}
