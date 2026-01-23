class ApiEndPoints {
  ApiEndPoints._();

  static const String baseUrl = 'https://mamunuiux.com';

  static const String imageBaseUrl = 'https://mamunuiux.com/flutter_task/';
  static const getHomeScreen = '$baseUrl/flutter_task/api';
  static const getSeeAllProduct = '$baseUrl/flutter_task/api/product';
  static productDetails(String productId) => '$baseUrl/flutter_task/api/product/$productId';
  static String productsByCategory(int categoryId) => '$baseUrl/flutter_task/api/product-by-category/$categoryId';
}