
 import 'package:news_app/features/category_details/data/data_sources/remote/Api_manager.dart';
import 'package:news_app/features/category_details/data/models/NewsResponse/Articles.dart';
import 'package:news_app/features/search/data/repositories/NewsSearchDataSource.dart';

class NewsSearchOnlineDataSource extends NewsSearchDataSource {
  ApiManager apiManager;

  NewsSearchOnlineDataSource(this.apiManager);// Constructor Injection

  @override
  Future<List<Articles>?> getNewsSearch(String value) async{
    var response = await apiManager.getSearch(value);
    return response.articles;
  }
}