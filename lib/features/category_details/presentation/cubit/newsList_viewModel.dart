import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/features/category_details/domain/repositories/NewsListRepository.dart';
import 'package:news_app/features/category_details/presentation/cubit/newsList_states.dart';

@injectable
class NewsListViewModel extends Cubit<NewsStates> {
  late NewsListRepository repository;

  @factoryMethod
  NewsListViewModel(this.repository) : super(NewsListInitial());
  
  void getNews(String categoryName) async {
    emit(NewsListLoading());
    try {
         var newsList = await repository.getNews(categoryName);
         emit(NewsListSuccess(newsList));
    } catch (e) {
      emit(NewsListError(e.toString()));
    }
  }
}