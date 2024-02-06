import 'package:injectable/injectable.dart';
import 'package:news_app/features/category_details/data/models/sources/Sources.dart';
import 'package:news_app/features/category_details/data/repositories/NewsSourceDataSource.dart';
import 'package:news_app/features/category_details/domain/repositories/NewsSourceRepository.dart';

@Injectable(as : NewsSourceRepository)
class NewsSourceRepositoryImp extends NewsSourceRepository {
  NewsSourceDataSource dataSource;

  @factoryMethod
  NewsSourceRepositoryImp(this.dataSource);// Constructor Injection

  @override
  Future<List<Source>?> getNewSources(String categoryName){
      return dataSource.getNewsSources(categoryName);
  }
}