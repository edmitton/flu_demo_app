import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier{
  bool isLoggedIn = false;
  bool get isLogged => isLoggedIn;

  void login() {
    isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    isLoggedIn = false;
    notifyListeners();
  }
}
