import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:news_provider/widgets/list_news.dart';
import 'package:news_provider/models/models.dart' show CategoryM;
import 'package:news_provider/services/services.dart' show NewsService;
import 'package:news_provider/config/theme.dart' show myTheme;

class Tab2Screen extends StatefulWidget {
  const Tab2Screen({Key? key}) : super(key: key);

  static const routeName = 'tab2';

  @override
  State<Tab2Screen> createState() => _Tab2ScreenState();
}

class _Tab2ScreenState extends State<Tab2Screen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final newsService = Provider.of<NewsService>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _ListCategories(
              categories: newsService.categories,
              selectedCategory: newsService.selectedCategory,
            ),
            Expanded(
              child: newsService.selectedCategoryArticlesIsLoading
                  ? Center(
                      child: CircularProgressIndicator(
                      color: myTheme.colorScheme.secondary,
                    ))
                  : ListNews(newsService.getSelectedCategoryArticles),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListCategories extends StatelessWidget {
  const _ListCategories({
    required this.categories,
    required this.selectedCategory,
    Key? key,
  }) : super(key: key);

  final List<CategoryM> categories;
  final String selectedCategory;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 91,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          return _ButtonCategory(
            category: categories[index],
            selectedCategory: selectedCategory,
          );
        },
      ),
    );
  }
}

class _ButtonCategory extends StatelessWidget {
  const _ButtonCategory({
    required this.category,
    required this.selectedCategory,
    Key? key,
  }) : super(key: key);

  final CategoryM category;
  final String selectedCategory;

  @override
  Widget build(BuildContext context) {
    final categoryNameCapitalized =
        '${category.name[0].toUpperCase()}${category.name.substring(1).toLowerCase()}';

    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: 50,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                final newsService =
                    Provider.of<NewsService>(context, listen: false);
                newsService.selectedCategory = category.name;
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(
                  category.icon,
                  color: selectedCategory == category.name
                      ? myTheme.colorScheme.secondary
                      : Colors.black54,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              categoryNameCapitalized,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: selectedCategory == category.name
                    ? myTheme.colorScheme.secondary
                    : Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
