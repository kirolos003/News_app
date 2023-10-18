import 'package:flutter/material.dart';
import 'package:news_app/Network/remote/Api_manager.dart';
import 'package:news_app/UI/Categories%20Details/souces_tab.dart';
import 'package:news_app/UI/screens/Home/categories/category_model.dart';
import 'package:news_app/model/NewsResponse/Articles.dart';
import 'package:news_app/model/sources/Sources.dart';
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
            return CategoryDetailsWidget(sourcesList! , category);
          }
        },
      ),
    );
  }
}

class CategoryDetailsWidget extends StatelessWidget {
  final List<Source> sources;
  Category category;
  CategoryDetailsWidget(this.sources , this.category);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SourcesTabsWidgets(sources),
            BuildCategoryDetailList(category),
          ],
        ),
      ),
    );
  }
}

class BuildCategoryDetailList extends StatelessWidget {
  Category category;
  BuildCategoryDetailList(this.category , { super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiManager.getNews(category.title),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || snapshot.data!.status == 'error') {
            return Center(child: Text('Error: ${snapshot.error.toString()}'));
          } else {
            var newsList = snapshot.data?.articles;
            return BuildCategoryDetailsItem(newsList!);
          }
        },
    );
  }
}

Widget BuildCategoryDetailsItem(List<Articles> articles) => Expanded(
  child:   ListView.builder(
      itemBuilder: (context , index) => NewsItemBuilder(articles[index]),
    itemCount: articles.length,
  ),
);


