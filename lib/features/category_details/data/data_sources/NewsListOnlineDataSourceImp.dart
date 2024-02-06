import 'package:injectable/injectable.dart';
import 'package:news_app/features/category_details/data/data_sources/remote/Api_manager.dart';
import 'package:news_app/features/category_details/data/models/NewsResponse/Articles.dart';
import '../repositories/NewsListDataSource.dart';

@Injectable(as : NewsListDataSource)
class NewsListOnlineDataSource extends NewsListDataSource{
  ApiManager apiManager;

  @factoryMethod
  NewsListOnlineDataSource(this.apiManager);// Constructor Injection

  @override
  Future<List<Articles>?> getNews(String categoryName) async{
    var response = await apiManager.getNews(categoryName);
    return response.articles;
  }

}