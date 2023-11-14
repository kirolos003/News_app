import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Network/remote/Api_manager.dart';
import 'package:news_app/features/category_details/presentation/cubit/newsList_states.dart';

class NewsListViewModel extends Cubit<NewsStates> {
  NewsListViewModel() : super(NewsListInitial());
  
  void getNews(String categoryName) async {
    emit(NewsListLoading());
    try {
         var response = await ApiManager.getNews(categoryName);
         if(response.status == 'error'){
           emit(NewsListError(response.message??"Error"));
         }else{
           emit(NewsListSuccess(response.articles));
         }
    } catch (e) {
      emit(NewsListError(e.toString()));
    }
  }
}