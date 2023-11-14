import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Network/remote/Api_manager.dart';
import 'package:news_app/features/category_details/presentation/cubit/newsList_states.dart';
import 'package:news_app/features/category_details/presentation/cubit/newsList_viewModel.dart';
import 'package:news_app/features/category_details/presentation/widgets/source_tab_widget.dart';
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

class BuildCategoryDetailList extends StatefulWidget {
  final String sourceName;
  BuildCategoryDetailList(this.sourceName , { super.key});

  @override
  State<BuildCategoryDetailList> createState() => _BuildCategoryDetailListState();
}

class _BuildCategoryDetailListState extends State<BuildCategoryDetailList> {
  NewsListViewModel viewModel = NewsListViewModel();
  initState() {
    viewModel.getNews(widget.sourceName);
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsListViewModel , NewsStates>(
      bloc: viewModel,
      builder: (context , state){
        switch(state){
          case NewsListLoading():{
            return const Center(child: CircularProgressIndicator());
          }
          case NewsListSuccess():{
            var sourcesList = state.newsList;
            return ListView.builder(
              itemBuilder:(context , index) => NewsItemBuilder(sourcesList![index] , context),
              itemCount: sourcesList?.length,
            );
              }
          case NewsListError():{
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: ${state.error}'),
                ElevatedButton(onPressed: () {
                  viewModel.getNews(widget.sourceName);
                }, child: Text('Try Again')),
              ],
            );
          }
          case NewsListInitial():{
            return const Center(child: CircularProgressIndicator());
          }
        }
      },
    );
  }
}
