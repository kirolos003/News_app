
import '../../data/models/sources/Sources.dart';

sealed class CategoryDetailsStates {}

class CategoryDetailsInitial extends CategoryDetailsStates {}

class CategoryDetailsLoading extends CategoryDetailsStates {}

class CategoryDetailsSuccess extends CategoryDetailsStates {
  List<Source>? sourcesList;

  CategoryDetailsSuccess({required this.sourcesList});
}

class CategoryDetailsError extends CategoryDetailsStates {
  final String error;

  CategoryDetailsError(this.error);
}

