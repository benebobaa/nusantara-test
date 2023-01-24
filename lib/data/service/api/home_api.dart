import 'package:dio/dio.dart';
import 'package:flutter_nusantara/data/local/token.dart';
import 'package:flutter_nusantara/data/service/constant/constant_api.dart';

class HomeApi {
  final Dio _dio = Dio();
  // ignore: unused_field
  final SharedPref _token = SharedPref();

  Future<Response> logout({
    required String token,
  }) async {
    try {
      Response res = await _dio.delete(
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
        ),
        ConstantApi.baseUrl + ConstantApi.homeLogout,
      );
      // if (res.statusCode == 200) {
      //   print('token: ${res.data['token']}');
      //   _token.deleteToken();
      // }
      return res;
    } on DioError catch (e) {
      return e.response!;
    }
  }

  Future<Response> getUser({
    required String token,
  }) async {
    try {
      Response res = await _dio.get(
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
        ),
        ConstantApi.baseUrl + ConstantApi.userEndpoint,
      );

      return res;
    } on DioError catch (e) {
      return e.response!;
    }
  }

  Future<Response> getBooks({
    required String token,
  }) async {
    try {
      Response res = await _dio.get(
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
        ),
        ConstantApi.baseUrl + ConstantApi.booksEndpoint,
      );

      return res;
    } on DioError catch (e) {
      return e.response!;
    }
  }

  Future<Response> postBook({
    required String isbn,
    required String title,
    required String subtitle,
    required String author,
    required String published,
    required String publisher,
    required String pages,
    required String description,
    required String website,
    required String token,
  }) async {
    try {
      Response res = await _dio.post(
          options: Options(
            headers: {
              'Accept': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ),
          ConstantApi.baseUrl + ConstantApi.bookaddEndpoint,
          data: {
            "isbn": isbn,
            "title": title,
            "subtitle": subtitle,
            "author": author,
            "published": published,
            "publisher": publisher,
            "pages": pages,
            "description": description,
            "website": website,
          });

      return res;
    } on DioError catch (e) {
      return e.response!;
    }
  }

  Future<Response> delBook({
    required String token,
    required int book,
  }) async {
    try {
      final bookId = book.toString();
      Response res = await _dio.delete(
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
        ),
        '${ConstantApi.baseUrl}${ConstantApi.booksEndpoint}/${bookId}',
      );
      // if (res.statusCode == 200) {
      //   print('token: ${res.data['token']}');
      //   _token.deleteToken();
      // }
      return res;
    } on DioError catch (e) {
      return e.response!;
    }
  }

  Future<Response> putBook({
    required String isbn,
    required String title,
    required String subtitle,
    required String author,
    required String published,
    required String publisher,
    required String pages,
    required String description,
    required String website,
    required String token,
    required int book,
  }) async {
    try {
      final bookId = book.toString();
      Response res = await _dio.put(
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
        ),
        '${ConstantApi.baseUrl}${ConstantApi.booksEndpoint}/${bookId}/edit',
        data: {
          "isbn": isbn,
          "title": title,
          "subtitle": subtitle,
          "author": author,
          "published": published,
          "publisher": publisher,
          "pages": pages,
          "description": description,
          "website": website,
        },
      );

      return res;
    } on DioError catch (e) {
      return e.response!;
    }
  }
}
