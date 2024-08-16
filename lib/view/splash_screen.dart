import 'package:flutter/material.dart';
import 'package:flutter_mvvm_bloc/services/splash/splash_service.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final SplashService _splashService = SplashService();
  @override
  void initState() {
    super.initState();
    _splashService.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Splash Screen",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      )),
    );
  }
}
