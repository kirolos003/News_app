import 'package:news_app/features/category_details/data/models/NewsResponse/Articles.dart';
import 'package:news_app/features/search/data/repositories/NewsSearchDataSource.dart';
import 'package:news_app/features/search/domain/repositories/NewsSearchRepository.dart';

class NewsSearchRepositoryImp extends NewsSearchRepository{
  NewsSearchDataSource dataSource;

  NewsSearchRepositoryImp(this.dataSource);

  @override
  Future<List<Articles>?> getNewsSearch(String value) {
    return dataSource.getNewsSearch(value);
  }
}