import 'package:dio/dio.dart';
import 'package:flutter_nusantara/data/local/token.dart';
import 'package:flutter_nusantara/data/service/constant/constant_api.dart';

class LoginApi {
  final Dio _dio = Dio();
  final SharedPref _token = SharedPref();

  Future<Response> postLogin({
    required String email,
    required String password,
  }) async {
    try {
      Response res = await _dio.post(
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
        ),
        ConstantApi.baseUrl + ConstantApi.loginEndpoint,
        data: {
          'email': email,
          'password': password,
        },
      );
      if (res.statusCode == 200) {
        print('token: ${res.data['token']}');
        _token.saveToken(token: res.data['token']);
      }
      return res;
    } on DioError catch (e) {
      return e.response!;
    }
  }
}
