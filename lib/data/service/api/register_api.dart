import 'package:dio/dio.dart';
import 'package:flutter_nusantara/data/service/constant/constant_api.dart';

class RegisterApi {
  Dio _dio = Dio();

  Future<Response> postRegister({
    required String name,
    required String email,
    required String password,
    required String confrimPass,
  }) async {
    try {
      Response res = await _dio.post(
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
        ),
        ConstantApi.baseUrl + ConstantApi.registerEndpoint,
        data: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': confrimPass,
        },
      );
      return res;
    } on DioError catch (e) {
      return e.response!;
    }
  }
}
