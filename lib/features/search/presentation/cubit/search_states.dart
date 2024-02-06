import '../../../category_details/data/models/NewsResponse/Articles.dart';

sealed class SearchScreenState{}

class SearchScreenInitialState extends SearchScreenState{}

class SearchScreenLoadingState extends SearchScreenState{}

class SearchScreenSuccessState extends SearchScreenState{
  final List<Articles>? search;
  SearchScreenSuccessState(this.search);
}

class SearchScreenErrorState extends SearchScreenState{
  final String error;
  SearchScreenErrorState(this.error);
}