import 'package:news_app/features/category_details/data/models/NewsResponse/Articles.dart';

abstract class NewsSearchDataSource {
  Future<List<Articles>?> getNewsSearch(String value);
}