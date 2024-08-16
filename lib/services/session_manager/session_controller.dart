import 'dart:convert';

import 'package:flutter_mvvm_bloc/model/user_model.dart';
import 'package:flutter_mvvm_bloc/services/storage/local_storage.dart';

class SessionController {
  // Singleton instance
  static final SessionController _sessionController =
      SessionController._internal();

  // Local storage instance
  final LocalStorage localStorage = LocalStorage();

  // User model instance
   UserModel _userModel = UserModel();

  // Login status
  bool? isLogin;

  // Private named constructor
  SessionController._internal() {
    isLogin = false;
  }

  // Factory constructor returns the singleton instance
  factory SessionController() {
    return _sessionController;
  }

  Future<void> saveUserInPreference(dynamic user) async {
    await localStorage.setValue("token", jsonEncode(user));
    await localStorage.setValue("isLogin", 'true');
  }

  Future<void> getUserFromPreference() async {
    var userData = await localStorage.getValue("token");
    var isLogin = await localStorage.getValue("isLogin");
    if (userData.toString().isNotEmpty) {
      SessionController()._userModel = UserModel.fromJson(jsonDecode(userData));
    }
    SessionController().isLogin = isLogin == "true" ? true : false;
  }

  Future<void> removeUserFromPreference() async {
    await localStorage.clearValue("token");
    await localStorage.clearValue("isLogin");
  }
}
