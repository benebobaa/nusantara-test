import 'package:flutter/widgets.dart';
import 'package:flutter_nusantara/data/local/token.dart';
import 'package:flutter_nusantara/data/service/api/home_api.dart';
import 'package:flutter_nusantara/features/home/viewmodel/home_viewmodel.dart';
import 'package:flutter_nusantara/utils/snackbar.dart';
import 'package:provider/provider.dart';

class SplashViewModel with ChangeNotifier {
  bool isLoading = false;
  final HomeApi _api = HomeApi();
  final SharedPref _token = SharedPref();
  String _username = '';
  String get username => _username;

  Future<void> initial(context) async {
    final token = await _token.readToken();
    isLoading = true;
    notifyListeners();
    print(token);
    if (token == null) {
      Navigator.pushReplacementNamed(context, '/login');
      return;
    }
    final response = await _api.getUser(token: token);

    if (response.statusCode == 200) {
      _username = response.data['name'];
      snackbarMessage(context, response.data['email']);
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      Provider.of<HomeViewModel>(context, listen: false).getBooks(context);
    } else {
      snackbarMessage(context, response.data['message']);
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }

    isLoading = false;
    notifyListeners();
  }
}
