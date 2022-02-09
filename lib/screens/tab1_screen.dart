import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:news_provider/widgets/list_news.dart';
import 'package:news_provider/services/services.dart' show NewsService;
import 'package:news_provider/config/theme.dart' show myTheme;

class Tab1Screen extends StatefulWidget {
  const Tab1Screen({Key? key}) : super(key: key);

  static const routeName = 'tab1';

  @override
  State<Tab1Screen> createState() => _Tab1ScreenState();
}

class _Tab1ScreenState extends State<Tab1Screen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final newsService = Provider.of<NewsService>(context);

    return SafeArea(
      child: Scaffold(
        body: newsService.headlines.isEmpty
            ? Center(
                child: CircularProgressIndicator(
                  color: myTheme.colorScheme.secondary,
                ),
              )
            : ListNews(newsService.headlines),
      ),
    );
  }
}
