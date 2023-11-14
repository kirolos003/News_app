import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/UI/screens/Home/categories/category_model.dart';
import 'package:news_app/features/category_details/presentation/cubit/category_details_states.dart';
import 'package:news_app/features/category_details/presentation/cubit/category_details_viewModel.dart';
import 'package:news_app/features/category_details/presentation/pages/souces_tab.dart';

class CategoryDetails extends StatefulWidget {
  final Category category;

  CategoryDetails(this.category, {super.key});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  CategoryDetailsViewModel viewModel = CategoryDetailsViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.getSources(widget.category.title);
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryDetailsViewModel , CategoryDetailsStates>(
        bloc: viewModel,
        builder: (context , state){
            switch(state){
              case CategoryDetailsSuccess() :{
                var sourcesList = state.sourcesList;
                return Scaffold(
                appBar: AppBar(
                        title: Text(widget.category.title),
                      ),
                  body: SourcesTabsWidgets(sourcesList!),
                );
              }
              case CategoryDetailsLoading() :{
                return Scaffold(
                  appBar: AppBar(
                    title: Text(widget.category.title),
                  ),
                  body: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: CircularProgressIndicator()),
                    ],
                  ),
                );
              }
              case CategoryDetailsError() :{
                return Scaffold(
                  appBar: AppBar(
                    title: Text(widget.category.title),
                  ),
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Error: ${state.error}'),
                      ElevatedButton(onPressed: () {
                        viewModel.getSources(widget.category.title);
                      }, child: Text('Try Again')),
                    ],
                  ),
                );
              }
              case CategoryDetailsInitial() :{
                return Scaffold(
                  appBar: AppBar(
                    title: Text(widget.category.title),
                  ),
                  body: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: CircularProgressIndicator()),
                    ],
                  ),
                );
              }
            }
        },
    );
  }
}
