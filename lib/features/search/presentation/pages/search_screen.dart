import 'package:flutter/material.dart';
import 'package:news_app/Network/remote/Api_manager.dart';
import 'package:news_app/features/search/presentation/view_model/search_view_model.dart';
import 'package:news_app/model/NewsResponse/Articles.dart';
import 'package:news_app/shared/components.dart';
import 'package:provider/provider.dart';

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
  SearchScreenViewModel viewModel = SearchScreenViewModel();

  initState() {
    super.initState();
    viewModel.getSearch(widget.search);
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => viewModel,
      child: Consumer<SearchScreenViewModel>(
        builder: (context , viewModel , child){
          if(viewModel.showLoading == true) {
            return const Center(child: CircularProgressIndicator());
          } else if (viewModel.errorMessage != null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: ${viewModel.errorMessage}'),
                ElevatedButton(onPressed: () {
                  viewModel.getSearch(widget.search);
                }, child: Text('Try Again')),
              ],
            );
          } else {
            var searchList = viewModel.searchList;
            return BuildCategoryDetailsItem(searchList!);
          }
        },
      ),
    );
  }
}

Widget BuildCategoryDetailsItem(List<Articles>? articles) => ListView.builder(
  itemBuilder: (context , index) => NewsItemBuilder(articles![index] , context),
  itemCount: articles?.length,
);