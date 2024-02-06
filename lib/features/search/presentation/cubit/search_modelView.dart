import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/search/data/repositories/NewsSearchOnlineDataSource.dart';
import 'package:news_app/features/search/data/repositories/NewsSearchRepositoryImp.dart';
import 'package:news_app/features/search/domain/repositories/NewsSearchRepository.dart';
import 'package:news_app/features/search/presentation/cubit/search_states.dart';
import '../../../category_details/data/data_sources/remote/Api_manager.dart';
import '../../data/repositories/NewsSearchDataSource.dart';

class SearchScreenViewModel extends Cubit<SearchScreenState> {
  late NewsSearchRepository repository;
  late NewsSearchDataSource dataSource;
  late ApiManager apiManager;

  SearchScreenViewModel() : super(SearchScreenInitialState()){
    apiManager = ApiManager();
    dataSource = NewsSearchOnlineDataSource(ApiManager());
    repository = NewsSearchRepositoryImp(dataSource);
  }

  void getSearch(String query) async {
    emit(SearchScreenLoadingState());
    try {
      var response = await repository.getNewsSearch(query);
      emit(SearchScreenSuccessState(response));
    } catch (e) {
      emit(SearchScreenErrorState(e.toString()));
    }
  }
}