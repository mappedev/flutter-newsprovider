import 'package:flutter/foundation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:news_provider/models/models.dart'
    show newsFromJson, Article, CategoryM;

const _urlNews = 'https://newsapi.org/v2';
const _country = 'us';
const _apiKey = '7a8c6b50997b49d0866efc71e514834e';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];
  List<CategoryM> categories = [
    CategoryM(icon: FontAwesomeIcons.building, name: 'business'),
    CategoryM(icon: FontAwesomeIcons.tv, name: 'entertainment'),
    CategoryM(icon: FontAwesomeIcons.addressCard, name: 'general'),
    CategoryM(icon: FontAwesomeIcons.headSideVirus, name: 'health'),
    CategoryM(icon: FontAwesomeIcons.vials, name: 'science'),
    CategoryM(icon: FontAwesomeIcons.volleyballBall, name: 'sports'),
    CategoryM(icon: FontAwesomeIcons.memory, name: 'technology'),
  ];
  String _selectedCategory = '';
  Map<String, List<Article>> categoryArticles = {};
  bool _selectedCategoryArticlesIsLoading = true;

  String get selectedCategory => _selectedCategory;
  set selectedCategory(String newValue) {
    getArticlesByCategory(newValue);
    _selectedCategory = newValue;

    notifyListeners();
  }

  bool get selectedCategoryArticlesIsLoading =>
      _selectedCategoryArticlesIsLoading;

  List<Article> get getSelectedCategoryArticles =>
      categoryArticles[_selectedCategory]!;

  void getTopHeadlines() async {
    const url = '$_urlNews/top-headlines?country=$_country&apiKey=$_apiKey';

    final res = await http.get(Uri.parse(url));
    final data = newsFromJson(res.body);

    headlines.addAll(data.articles);
    notifyListeners();
  }

  void getArticlesByCategory(String category) async {
    if (categoryArticles[category] == null ||
        categoryArticles[category]!.isNotEmpty) {
      _selectedCategoryArticlesIsLoading = false;
      notifyListeners();
      return;
    }

    if (!_selectedCategoryArticlesIsLoading) {
      _selectedCategoryArticlesIsLoading = true;
      notifyListeners();
    }

    final url =
        '$_urlNews/top-headlines?country=$_country&apiKey=$_apiKey&category=$category';

    final res = await http.get(Uri.parse(url));
    final data = newsFromJson(res.body);

    categoryArticles[category]!.addAll(data.articles);

    _selectedCategoryArticlesIsLoading = false;
    notifyListeners();
  }

  NewsService() {
    _selectedCategory = categories[0].name;
    for (var category in categories) {
      categoryArticles[category.name] = [];
    }

    getTopHeadlines();
    getArticlesByCategory(_selectedCategory);
  }
}
