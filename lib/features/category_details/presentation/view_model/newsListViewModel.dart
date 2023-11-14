import 'package:flutter/material.dart';
import 'package:news_app/Network/remote/Api_manager.dart';
import 'package:news_app/model/NewsResponse/Articles.dart';

class NewsListViewModel extends ChangeNotifier {
  List<Articles>? newsList = [];
  String? errorMessage;
  bool? showLoading;

  getNews(String categoryTitle) async {
    // we make them equal to null just in case there was no internet connection and we pressed try again and we called this function we have to clear the error message or it will display the same error message
    showLoading = true;
    errorMessage = null;
    newsList = null;
    try {
      showLoading = true;
      notifyListeners();
      var response = await ApiManager.getNews(categoryTitle);
      if (response.status == 'error') {
        showLoading = false;
        print('Error: ${response.message}');
        errorMessage = response.message;
      } else {
        showLoading = false;
        print('Success: ${response.articles}');
        newsList = response.articles;
      }
    } catch (e) {
      showLoading = false;
      print(e.toString());
      errorMessage =
          "There was a problem in the internet connection. Please try again";
    }
    notifyListeners();
  }
}