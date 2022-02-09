import 'package:flutter/material.dart';
import 'package:news_provider/screens/screens.dart';
import 'package:provider/provider.dart';
import 'package:news_provider/config/theme.dart' show myTheme;
import 'package:news_provider/providers/providers.dart' show NavigationProvider;

class TabsScreen extends StatelessWidget {
  const TabsScreen({Key? key}) : super(key: key);

  static const routeName = 'tabs';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NavigationProvider(),
      child: const Scaffold(
        body: _Pages(),
        bottomNavigationBar: _Navigation(),
      ),
    );
  }
}

class _Navigation extends StatelessWidget {
  const _Navigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);

    return BottomNavigationBar(
      currentIndex: navigationProvider.currentScreen,
      onTap: (i) {
        navigationProvider.currentScreen = i;
        navigationProvider.pageController.animateToPage(
          i,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      },
      selectedItemColor: myTheme.colorScheme.secondary,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outlined),
          label: 'Para tí',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.public_outlined),
          label: 'Encabezado',
        ),
      ],
    );
  }
}

class _Pages extends StatelessWidget {
  const _Pages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationprovider = Provider.of<NavigationProvider>(context);

    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: navigationprovider.pageController,
      children: const [
        Tab1Screen(),
        Tab2Screen(),
      ],
    );
  }
}
