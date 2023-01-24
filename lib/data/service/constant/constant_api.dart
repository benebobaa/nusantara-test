class ConstantApi {
  ConstantApi._();

  /// Base Url
  static const String baseUrl =
      'https://basic-book-crud-e3u54evafq-et.a.run.app';

  /// Receive Timeout
  static const int receiveTimeout = 15000;

  /// Conection Timeout
  static const int connectionTimeout = 15000;

  /// Endpoints
  static const String loginEndpoint = '/api/login';
  static const String registerEndpoint = '/api/register';
  static const String homeLogout = '/api/user/logout';
  static const String userEndpoint = '/api/user';
  static const String booksEndpoint = '/api/books';
  static const String bookaddEndpoint = '/api/books/add';
}
