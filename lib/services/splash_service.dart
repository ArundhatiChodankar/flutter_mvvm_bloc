import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mvvm_bloc/utils/routes/routes_name.dart';

class SplashService {
  void isLogin(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(
          context, RouteNames.home, (route) => false);
    });
  }
}
