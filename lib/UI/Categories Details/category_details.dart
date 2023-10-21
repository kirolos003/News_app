import 'package:flutter/material.dart';
import 'package:news_app/Network/remote/Api_manager.dart';
import 'package:news_app/UI/Categories%20Details/souces_tab.dart';
import 'package:news_app/UI/screens/Home/categories/category_model.dart';
import 'package:news_app/shared/components.dart';

class CategoryDetails extends StatelessWidget {
  final Category category;

  CategoryDetails(this.category);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
      ),
      body: FutureBuilder(
        future: ApiManager.getSources(category.title),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || snapshot.data!.status == 'error') {
            return Center(child: Text('Error: ${snapshot.error.toString()}'));
          } else {
            var sourcesList = snapshot.data?.sources;
            return SourcesTabsWidgets(sourcesList!);
          }
        },
      ),
    );
  }
}
