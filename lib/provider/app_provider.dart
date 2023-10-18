import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_app/Network/local/cache_helper.dart';
import 'package:news_app/Network/remote/dio_helper.dart';
import 'package:news_app/UI/screens/Home/categories/categories.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/model/NewsResponse/NewsModel.dart';


class AppProvider extends ChangeNotifier {
  String isEnglish = 'ar';

  void changeAppLanguage({String? fromShared}) {
    if (fromShared != null) {
      isEnglish = fromShared;
    } else {
      isEnglish = (isEnglish == 'en') ? 'ar' : 'en';
      CacheHelper.saveData(key: 'isEnglish', value: isEnglish);
    }
    notifyListeners();
  }

  bool isDark = false;

  void changeAppTheme({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      notifyListeners();
    } else {
      isDark = !isDark;
      CacheHelper.saveData(key: 'isDark', value: isDark)
          .then((value) => notifyListeners());
    }
  }

  bool isPassword = true;
  IconData suffix = Icons.visibility_off_outlined;
  void changeSuffixVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_off_outlined : Icons.visibility;
    notifyListeners();
  }

  Widget selectedWidget= CategoriesWidget();
  void changeDrawerItem(Widget changed){
    selectedWidget = changed;
    notifyListeners();
  }

  int current = 0;
  void refresh(int index){
    current = index;
    notifyListeners();
  }

  // var searchResponse ;
  // void getSearch ({
  //   String? text
  // })async
  // {
  //    const baseUrl = 'newsapi.org';
  //    const key = '8bc9767c8ffc48d484f0af085e0fc3d4';
  //   var url = Uri.https(
  //       baseUrl, 'v2/everything', {
  //     'apiKey': key,
  //     'q': text,
  //   });
  //   var response = await http.get(url);
  //   var json = jsonDecode(response.body);
  //   searchResponse = NewsModel.fromJson(json);
  // }
}


