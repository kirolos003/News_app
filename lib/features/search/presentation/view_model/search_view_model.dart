import 'package:flutter/material.dart';
import 'package:news_app/Network/remote/Api_manager.dart';
import 'package:news_app/model/NewsResponse/Articles.dart';

class SearchScreenViewModel extends ChangeNotifier{
  String? errorMessage;
  bool? showLoading;
  List<Articles>? searchList = [];

  getSearch(String searchWord) async{
    // we make them equal to null just in case there was no internet connection and we pressed try again and we called this function we have to clear the error message or it will display the same error message
    showLoading = true;
    errorMessage = null;
    searchList = null;
    try{
      showLoading = true;
      notifyListeners();
      var response = await ApiManager.getSearch(searchWord);
      if(response.status == 'error') {
        showLoading = false;
        errorMessage = response.message;
      } else {
        showLoading = false;
        searchList = response.articles;
      }
    }catch(e){
      showLoading = false;
      errorMessage = "There was a problem in the internet connection. Please try again";
    }
    notifyListeners();
  }
}