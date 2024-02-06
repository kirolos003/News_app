import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/features/category_details/presentation/cubit/category_details_states.dart';
import '../../domain/repositories/NewsSourceRepository.dart';

@injectable
class CategoryDetailsViewModel extends Cubit<CategoryDetailsStates>{
  late NewsSourceRepository repository;

  @factoryMethod
  CategoryDetailsViewModel(this.repository):super(CategoryDetailsInitial());

  void getSources(String categoryTitle)async{
    emit(CategoryDetailsLoading());
    try{
      var sources = await repository.getNewSources(categoryTitle);
      emit(CategoryDetailsSuccess(sourcesList : sources));
    }catch(error){
      emit(CategoryDetailsError(error.toString()));
    }
  }
}