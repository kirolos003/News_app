import 'package:flutter/material.dart';
import 'package:news_app/Network/remote/Api_manager.dart';
import 'package:news_app/UI/Categories%20Details/source_tab_widget.dart';
import 'package:news_app/model/sources/Sources.dart';
import 'package:news_app/provider/app_provider.dart';
import 'package:news_app/shared/components.dart';
import 'package:provider/provider.dart';

class SourcesTabsWidgets extends StatelessWidget {
  List<Source> sources;
  SourcesTabsWidgets(this.sources, {super.key});

  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    return DefaultTabController(
      length: sources.length,
      child: Column(
        children: [
          TabBar(
              indicatorColor: Colors.transparent,
              onTap: (newIndex) {
                provider.refresh(newIndex);
              },
              isScrollable: true,
              tabs: sources
                  .map((Source) => TabWidget(Source, sources.indexOf(Source) == provider.current))
                  .toList()),
          Expanded(
              child: TabBarView(
            children: sources.map((singleSource) => BuildCategoryDetailList(singleSource.name!)).toList(),
          )),
        ],
      ),
    );
  }
}

class BuildCategoryDetailList extends StatelessWidget {
  final String sourceName;

  const BuildCategoryDetailList(this.sourceName , { super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManager.getNews(sourceName),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || snapshot.data!.status == 'error') {
          return Center(child: Text('Error: ${snapshot.error.toString()}'));
        } else {
          var newsList = snapshot.data?.articles;
          return ListView.builder(
            itemBuilder:(context , index) => NewsItemBuilder(newsList![index] , context),
            itemCount: newsList?.length,
          );
        }
      },
    );
  }
}
