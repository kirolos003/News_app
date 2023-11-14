import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Network/remote/Api_manager.dart';
import 'package:news_app/features/search/presentation/cubit/search_states.dart';

class SearchScreenModelView extends Cubit<SearchScreenState> {
  SearchScreenModelView() : super(SearchScreenInitialState());

  void getSearch(String query) async {
    emit(SearchScreenLoadingState());
    try {
      var response = await ApiManager.getSearch(query);
      if(response.status == 'error'){
        emit(SearchScreenErrorState(response.message??"Error"));
      }else{
        emit(SearchScreenSuccessState(response.articles));
      }
    } catch (e) {
      emit(SearchScreenErrorState(e.toString()));
    }
  }
}