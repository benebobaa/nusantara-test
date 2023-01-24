
import 'package:flutter/material.dart';
import 'package:flutter_nusantara/features/splash/viewmodel/splash_viewmodel.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SplashViewModel vm;

  @override
  void initState() {
    vm = Provider.of<SplashViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      vm.initial(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(80),
        child: Center(
          child: Lottie.asset("assets/splash_animation.json",
              height: 200, width: 200),
        ),
      ),
    );
  }
}
