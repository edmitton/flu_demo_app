import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier{
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> login() async {
    _isLoggedIn = true;
    notifyListeners();
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(seconds: 1));
    _isLoggedIn = false;
    notifyListeners();
  }
}
