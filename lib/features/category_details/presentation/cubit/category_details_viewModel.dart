import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Network/remote/Api_manager.dart';
import 'package:news_app/features/category_details/presentation/cubit/category_details_states.dart';

class CategoryDetailsViewModel extends Cubit<CategoryDetailsStates>{
  CategoryDetailsViewModel():super(CategoryDetailsInitial());

  void getSources(String categoryTitle)async{
    emit(CategoryDetailsLoading());
    try{
      var response = await ApiManager.getSources(categoryTitle);
      if(response.status == 'error') {
        emit(CategoryDetailsError(response.message??"Error"));
      }else{
        emit(CategoryDetailsSuccess(sourcesList: response.sources));
      }
    }catch(error){
      emit(CategoryDetailsError(error.toString()));
    }

  }
}