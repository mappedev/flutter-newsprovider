import 'package:flutter/material.dart';

// Esto es un provider porque es un estado local
class NavigationProvider with ChangeNotifier {
  int _currentScreen = 0;
  final PageController _pageController = PageController();

  int get currentScreen => _currentScreen;
  set currentScreen(int value) {
    _currentScreen = value;
    // _pageController.animateToPage(value, duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
    notifyListeners();
  }

  PageController get pageController => _pageController;
}
