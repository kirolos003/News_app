import 'package:news_app/features/category_details/data/models/NewsResponse/Articles.dart';

abstract class NewsListRepository {
  Future<List<Articles>?> getNews(String categoryName);
}