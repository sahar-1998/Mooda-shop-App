class ApiSetting {
  static const _baseUrl = "https://smart-store.mr-dev.tech/";
  static const _apiUrl = _baseUrl + "api/";

  static const register = _apiUrl + 'auth/register';
  static const login = _apiUrl + 'auth/login';
  static const logout = _apiUrl + 'auth/logout';
  static const activate = _apiUrl +'auth/activate';

  static const forgetPassword = _apiUrl + 'auth/forget-password';
  static const resetPassword = _apiUrl+ 'auth/reset-password';


  static const categories = _apiUrl + 'categories';
  static const subCategory = _apiUrl +'categories/{id}';
  static const products = _apiUrl +'sub-categories/';
  static const productDetails = _apiUrl +'products/';


  static const cities = _apiUrl+ 'cities';
  static const String home = _apiUrl + 'home';

  static const faq = _apiUrl +'faqs';
  static const contactRequest = _apiUrl+'contact-requests';

  static const favoriteProducts = _apiUrl +'favorite-products';


  static const storeApiKey = '3e270f50-ce6e-487e-beda-7dfec61bd5b7';


}