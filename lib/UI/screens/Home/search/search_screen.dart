import 'package:flutter/material.dart';
import 'package:news_app/Network/remote/Api_manager.dart';
import 'package:news_app/UI/Categories%20Details/category_details.dart';
import 'package:news_app/shared/components.dart';

class MainSearchScreen extends StatefulWidget {
  @override
  _MainSearchScreenState createState() => _MainSearchScreenState();
}

class _MainSearchScreenState extends State<MainSearchScreen> {
  String search = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: "Type anything to search",
                ),
                onChanged: (value) {
                  setState(() {
                    search = value;
                    SearchScreen(search: search,);
                  });
                },
              ),
              Expanded(child: SearchScreen(search: search)),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchScreen extends StatelessWidget {
  String search;
  SearchScreen({required  this.search , Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiManager.getSearch(search),
        builder:(context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || snapshot.data!.status == 'error') {
            return Center(child: Text(''));
          } else {
            var searchList = snapshot.data?.articles;
            return BuildCategoryDetailsItem(searchList!);
          }
        },
    );
  }
}
