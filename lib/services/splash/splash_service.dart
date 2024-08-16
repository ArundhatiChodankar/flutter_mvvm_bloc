import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mvvm_bloc/services/session_manager/session_controller.dart';
import 'package:flutter_mvvm_bloc/utils/routes/routes_name.dart';

class SplashService {
  void isLogin(BuildContext context) {

    SessionController().getUserFromPreference().then((value) {
      SessionController().isLogin == true?
      Navigator.pushNamedAndRemoveUntil(
          context, RouteNames.home, (route) => false): Navigator.pushNamedAndRemoveUntil(
          context, RouteNames.login, (route) => false);
    }).onError((error, stackTrace) {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushNamedAndRemoveUntil(
            context, RouteNames.login, (route) => false);
      });
    });
  }
}
