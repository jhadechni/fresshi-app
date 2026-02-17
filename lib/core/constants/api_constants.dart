abstract final class ApiConstants {
  static const String baseUrl = 'https://fakestoreapi.com';

  // Endpoints
  static const String products = '/products';
  static const String categories = '/products/categories';
  static const String carts = '/carts';
  static const String users = '/users';
  static const String auth = '/auth/login';

  static String productsByCategory(String category) =>
      '/products/category/$category';
  static String productById(int id) => '/products/$id';
  static String cartByUser(int userId) => '/carts/user/$userId';

  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 10);
}
