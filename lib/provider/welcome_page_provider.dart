import 'package:flutter/material.dart';

class WelcomePageProvider extends ChangeNotifier{
  bool _showLoginSelection = true;
  bool get showLoginSelection => _showLoginSelection;

  void setInitialView(bool initialShowLoginSelection) {
    _showLoginSelection = initialShowLoginSelection;
    notifyListeners();
  }

  void toggleView() {
    _showLoginSelection = !_showLoginSelection;
    notifyListeners();
  }
}
