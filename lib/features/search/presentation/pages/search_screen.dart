import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Network/remote/Api_manager.dart';
import 'package:news_app/features/search/presentation/cubit/search_modelView.dart';
import 'package:news_app/features/search/presentation/cubit/search_states.dart';
import 'package:news_app/model/NewsResponse/Articles.dart';
import 'package:news_app/shared/components.dart';

class MainSearchScreen extends StatefulWidget {
  @override
  MainSearchScreenState createState() => MainSearchScreenState();
}

class MainSearchScreenState extends State<MainSearchScreen> {
  String search = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                hintText: "Type anything to search",
              ),
              onChanged: (value) {
                setState(() {
                  search = value;
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError || snapshot.data!.status == 'error') {
                  return const Center(child: Text(''));
                } else {
                  var searchList =  snapshot.data?.articles;
                  return Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: ListView.builder(
                      itemBuilder: (context , index) => NewsItemBuilder(searchList[index] , context),
                      itemCount: searchList.length
                    ),
                  );
                }
              },
              future: ApiManager.getSearch(search),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchScreen extends StatefulWidget {
  String search;

  SearchScreen({required  this.search , Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchScreenModelView viewModel = SearchScreenModelView();
  @override
  void initState() {
    super.initState();
    viewModel.getSearch(widget.search);
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchScreenModelView, SearchScreenState>(
      bloc : viewModel,
      builder: (context, state) {
        switch(state){
          case SearchScreenLoadingState():{
            return const Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
              ],
            ));
          }
          case SearchScreenSuccessState():{
            var searchList = state.search;
            return BuildCategoryDetailsItem(searchList!);
          }
          case SearchScreenErrorState() :{
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: ${state.error}'),
                ElevatedButton(onPressed: () {
                  viewModel.getSearch(widget.search);
                }, child: Text('Try Again')),
              ],
            );
          }
          case SearchScreenInitialState():{
            return const Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
              ],
            ));
          }
        }
      },
    );
  }
}

Widget BuildCategoryDetailsItem(List<Articles>? articles) => ListView.builder(
  itemBuilder: (context , index) => NewsItemBuilder(articles![index] , context),
  itemCount: articles?.length,
);