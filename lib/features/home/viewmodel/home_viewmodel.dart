import 'package:flutter/widgets.dart';
import 'package:flutter_nusantara/data/local/token.dart';
import 'package:flutter_nusantara/data/service/api/home_api.dart';
import 'package:flutter_nusantara/features/home/model/book_model.dart';
import 'package:flutter_nusantara/utils/snackbar.dart';

class HomeViewModel with ChangeNotifier {
  bool isLoading = false;
  final SharedPref _token = SharedPref();
  final HomeApi _api = HomeApi();

  List<Data> _data = [];
  List<Data> get data => _data;

  Future<void> logout(context) async {
    final token = await _token.readToken();
    isLoading = true;
    notifyListeners();
    print(token);
    final response = await _api.logout(token: token!);

    if (response.statusCode == 200) {
      snackbarMessage(context, response.data['message']);
      await _token.deleteToken();
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    } else {
      snackbarMessage(context, response.data['message']);
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> getBooks(context) async {
    final token = await _token.readToken();
    isLoading = true;
    notifyListeners();
    print(token);
    if (token == null) {
      Navigator.pushReplacementNamed(context, '/login');
      return;
    }
    final response = await _api.getBooks(token: token);
    print(response.data['data']);
    if (response.statusCode == 200) {
      _data = (response.data['data'] as List)
          .map<Data>((e) => Data.fromJson(e))
          .toList();
      print(data);
      snackbarMessage(context, 'Success get data');
    } else {
      snackbarMessage(context, 'Error get data');
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> addBook(
      context,
      String isbn,
      String title,
      String subtitle,
      String author,
      String published,
      String publisher,
      String pages,
      String description,
      String website) async {
    final token = await _token.readToken();
    isLoading = true;
    notifyListeners();
    print(token);
    if (token == null) {
      Navigator.pushReplacementNamed(context, '/login');
      return;
    }
    final response = await _api.postBook(
        token: token,
        isbn: isbn,
        title: title,
        subtitle: subtitle,
        author: author,
        published: published,
        publisher: publisher,
        pages: pages,
        description: description,
        website: website);
    print(response.data['data']);
    if (response.statusCode == 200) {
      print(data);
      snackbarMessage(context, response.data['message']);
      await getBooks(context);
      Navigator.pop(context);
    } else {
      snackbarMessage(context, response.data['message']);
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> deleteBook(context, int id) async {
    final token = await _token.readToken();
    isLoading = true;
    notifyListeners();
    print(token);
    if (token == null) {
      Navigator.pushReplacementNamed(context, '/login');
      return;
    }
    final response = await _api.delBook(token: token, book: id);

    if (response.statusCode == 200) {
      await getBooks(context);
      snackbarMessage(context, response.data['message']);

      Navigator.pushNamed(context, '/home');
    } else {
      snackbarMessage(context, response.data['message']);
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> editBook(
      context,
      String isbn,
      String title,
      String subtitle,
      String author,
      String published,
      String publisher,
      String pages,
      String description,
      String website,
      int id) async {
    final token = await _token.readToken();
    isLoading = true;
    notifyListeners();
    print(token);
    if (token == null) {
      Navigator.pushReplacementNamed(context, '/login');
      return;
    }
    final response = await _api.putBook(
      token: token,
      isbn: isbn,
      title: title,
      subtitle: subtitle,
      author: author,
      published: published,
      publisher: publisher,
      pages: pages,
      description: description,
      website: website,
      book: id,
    );
    print(response.data['data']);
    if (response.statusCode == 200) {
      print(data);
      snackbarMessage(context, response.data['message']);
      await getBooks(context);
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } else {
      snackbarMessage(context, response.data['message']);
    }

    isLoading = false;
    notifyListeners();
  }
}
