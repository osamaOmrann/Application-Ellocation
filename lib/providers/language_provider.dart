import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  String currentLanguage = 'en';

  void changeLanguage(String newLang) {
    if (newLang == currentLanguage) return;
    currentLanguage = newLang;
    notifyListeners();
  }
}
