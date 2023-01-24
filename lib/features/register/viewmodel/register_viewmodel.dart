import 'package:flutter/widgets.dart';

import 'package:flutter_nusantara/data/service/api/register_api.dart';

import 'package:flutter_nusantara/utils/snackbar.dart';

class RegisterViewModel with ChangeNotifier {
  final RegisterApi _api = RegisterApi();

  bool isLoading = false;

  Future<void> register(String name, String email, String password,
      String confirmPass, context) async {
    isLoading = true;
    notifyListeners();

    final response = await _api.postRegister(
      name: name,
      email: email,
      password: password,
      confrimPass: confirmPass,
    );

    if (response.statusCode == 200) {
      snackbarMessage(context, response.data['message']);
      Navigator.pushNamed(context, '/login');
    } else if (response.statusCode == 422) {
      snackbarMessage(context, response.data['message']);
    }
    isLoading = false;
    notifyListeners();
  }
}
