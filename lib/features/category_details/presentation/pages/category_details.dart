import 'package:flutter/material.dart';
import 'package:news_app/features/category_details/presentation/pages/souces_tab.dart';
import 'package:news_app/UI/screens/Home/categories/category_model.dart';
import 'package:news_app/features/category_details/presentation/view_model/categoryDetailsViewModel.dart';
import 'package:provider/provider.dart';

class CategoryDetails extends StatefulWidget {
  final Category category;
  CategoryDetails(this.category, {super.key});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  var viewModel = CategoryDetailsViewModel();
  @override
  void initState() {
    super.initState();
    viewModel.getSources(widget.category.title);
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<CategoryDetailsViewModel>(
        builder: (context , viewModel , child){
          if (viewModel.showLoading == true) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  widget.category.title,
                )
              ),
                body: const Center(child: Column(
                  children: [
                    CircularProgressIndicator(),
                  ],
                )));
          }
          if (viewModel.errorMessage != null) {
            return Center(
              child: Scaffold(
                appBar: AppBar(
                    title: Text(
                      widget.category.title,
                    )
                ),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${viewModel.errorMessage}'),
                    ElevatedButton(onPressed: () {
                      viewModel.getSources(widget.category.title);
                    }, child: Text('Try Again')),
                  ],
                ),
              ),
            );
          }else{
            var sourcesList = viewModel.newsSourcesList;
            return Scaffold(
                appBar: AppBar(
                    title: Text(
                      widget.category.title,
                    )
                ),
                body: SourcesTabsWidgets(sourcesList!));
          }
        },
      ),
    );
  }
}
