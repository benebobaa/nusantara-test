import 'package:flutter/widgets.dart';
import 'package:flutter_nusantara/data/service/api/login_api.dart';
import 'package:flutter_nusantara/utils/snackbar.dart';

class LoginViewModel with ChangeNotifier {
  LoginApi _api = LoginApi();
  bool isLoading = false;

  Future<void> login(String email, String password, context) async {
    isLoading = true;
    notifyListeners();

    final response = await _api.postLogin(
      email: email,
      password: password,
    );

    if (response.statusCode == 200) {
      snackbarMessage(context, response.data['message']);
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } else {
      snackbarMessage(context, response.data['message']);
    }

    isLoading = false;
    notifyListeners();
  }
}
