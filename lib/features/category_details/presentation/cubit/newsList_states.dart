import 'package:news_app/model/NewsResponse/Articles.dart';

sealed class NewsStates {}

class NewsListInitial extends NewsStates {}

class NewsListLoading extends NewsStates {}

class NewsListSuccess extends NewsStates {
  final List<Articles>? newsList;

  NewsListSuccess(this.newsList);
}

class NewsListError extends NewsStates {
  final String error;

  NewsListError(this.error);
}

