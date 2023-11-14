import 'package:flutter/material.dart';
import 'package:news_app/Network/remote/Api_manager.dart';
import 'package:news_app/model/sources/Sources.dart';

class CategoryDetailsViewModel extends ChangeNotifier{
  List<Source>? newsSourcesList = [];
  String? errorMessage;
  bool? showLoading;
  getSources(String categoryTitle) async{
    // we make them equal to null just in case there was no internet connection and we pressed try again and we called this function we have to clear the error message or it will display the same error message
    showLoading = true;
    errorMessage = null;
    newsSourcesList = null;
    try{
      showLoading = true;
      notifyListeners();
      var response = await ApiManager.getSources(categoryTitle);
      if(response.status == 'error') {
        showLoading = false;
        print('Error: ${response.message}');
        errorMessage = response.message;
      } else {
        showLoading = false;
        print('Success: ${response.sources}');
        newsSourcesList = response.sources;
      }
    }catch(e){
      showLoading = false;
      print(e.toString());
      errorMessage = "There was a problem in the internet connection. Please try again";
    }
    notifyListeners();
  }
}