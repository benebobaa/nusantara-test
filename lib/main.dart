import 'package:flutter/material.dart';
import 'package:flutter_nusantara/features/home/view/addbook_screen.dart';
import 'package:flutter_nusantara/features/home/view/detailbook_screen.dart';
import 'package:flutter_nusantara/features/home/view/editbook_screen.dart';
import 'package:flutter_nusantara/features/home/view/home_screen.dart';
import 'package:flutter_nusantara/features/home/viewmodel/home_viewmodel.dart';

import 'package:flutter_nusantara/features/login/view/login_screen.dart';
import 'package:flutter_nusantara/features/login/viewmodel/login_viewmodel.dart';
import 'package:flutter_nusantara/features/register/view/register_screen.dart';
import 'package:flutter_nusantara/features/register/viewmodel/register_viewmodel.dart';
import 'package:flutter_nusantara/features/splash/view/splash_screen.dart';
import 'package:flutter_nusantara/features/splash/viewmodel/splash_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => SplashViewModel(),
    ),
    ChangeNotifierProvider(
      create: (_) => RegisterViewModel(),
    ),
    ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
    ),
    ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nusantara-app-test',
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/addbook': (context) => const AddbookScreen(),
        '/detailbook': (context) => const DetailBook(),
        '/editbook': (context) => const EditbookScreen(),
      },
    );
  }
}
