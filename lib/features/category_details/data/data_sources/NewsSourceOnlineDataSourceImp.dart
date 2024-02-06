import 'package:injectable/injectable.dart';
import 'package:news_app/features/category_details/data/data_sources/remote/Api_manager.dart';
import 'package:news_app/features/category_details/data/repositories/NewsSourceDataSource.dart';
import '../models/sources/Sources.dart';

@Injectable(as : NewsSourceDataSource)
class NewsSourceOnlineDataSourceImp extends NewsSourceDataSource{
  ApiManager apiManager;

  @factoryMethod
  NewsSourceOnlineDataSourceImp(this.apiManager);// Constructor Injection

  @override
  Future<List<Source>?> getNewsSources(String categoryName)async{
    var response = await apiManager.getSources(categoryName);
    return response.sources;
  }
}