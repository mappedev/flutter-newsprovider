import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:news_provider/screens/screens.dart' show TabsScreen;
import 'package:news_provider/services/services.dart' show NewsService;
import 'package:news_provider/config/theme.dart' show myTheme;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => NewsService())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: myTheme,
        title: 'News Provider App',
        home: const TabsScreen(),
      ),
    );
  }
}
