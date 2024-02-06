import 'package:news_app/features/category_details/data/models/NewsResponse/Articles.dart';

abstract class NewsSearchRepository {
  Future<List<Articles>?> getNewsSearch(String value);
}