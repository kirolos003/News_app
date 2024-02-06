import 'package:flutter/material.dart';
import 'package:news_app/UI/screens/Home/categories/categories.dart';

import '../features/category_details/data/data_sources/local/cache_helper.dart';


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
}


