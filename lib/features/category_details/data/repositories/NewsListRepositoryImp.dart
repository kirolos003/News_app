import 'package:injectable/injectable.dart';
import 'package:news_app/features/category_details/data/models/NewsResponse/Articles.dart';
import 'package:news_app/features/category_details/data/repositories/NewsListDataSource.dart';
import 'package:news_app/features/category_details/domain/repositories/NewsListRepository.dart';

@Injectable(as: NewsListRepository)
class NewsListRepositoryImp extends NewsListRepository{
  NewsListDataSource dataSource;

  @factoryMethod
  NewsListRepositoryImp(this.dataSource);// Constructor Injection

  @override
  Future<List<Articles>?> getNews(String categoryName) {
        return dataSource.getNews(categoryName);
  }
}