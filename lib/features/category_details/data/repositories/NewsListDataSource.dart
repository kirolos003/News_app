import 'package:news_app/features/category_details/data/models/NewsResponse/Articles.dart';

abstract class NewsListDataSource {
  Future<List<Articles>?> getNews(String categoryName);
}