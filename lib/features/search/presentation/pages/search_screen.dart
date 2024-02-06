import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/search/presentation/cubit/search_modelView.dart';
import 'package:news_app/features/search/presentation/cubit/search_states.dart';
import 'package:news_app/shared/components.dart';
import '../../../category_details/data/models/NewsResponse/Articles.dart';

class MainSearchScreen extends StatefulWidget {
  const MainSearchScreen({super.key});

  @override
  State<MainSearchScreen> createState() => _MainSearchScreenState();
}

class _MainSearchScreenState extends State<MainSearchScreen> {
  late SearchScreenViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = SearchScreenViewModel();
  }

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
                viewModel.getSearch(value);
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<SearchScreenViewModel, SearchScreenState>(
              bloc: viewModel,
              builder: (context, state) {
                if (state is SearchScreenLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SearchScreenSuccessState) {
                  var searchList = state.search;
                  return Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: BuildCategoryDetailsItem(searchList),
                  );
                } else if (state is SearchScreenErrorState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Error: ${state.error}'),
                      ElevatedButton(
                        onPressed: () {
                          viewModel.getSearch(state.error);
                        },
                        child: const Text('Try Again'),
                      ),
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SearchScreen extends StatefulWidget {
  final String search;

  const SearchScreen({required this.search, Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late SearchScreenViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = SearchScreenViewModel();
    viewModel.getSearch(widget.search);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchScreenViewModel, SearchScreenState>(
      bloc: viewModel,
      builder: (context, state) {
        if (state is SearchScreenLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        else if (state is SearchScreenSuccessState) {
          var searchList = state.search;
          return BuildCategoryDetailsItem(searchList);
        }
        else if (state is SearchScreenErrorState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: ${state.error}'),
              ElevatedButton(
                onPressed: () {
                  viewModel.getSearch(widget.search);
                },
                child: const Text('Try Again'),
              ),
            ],
          );
        } else {
          return const Center(child: Column());
        }
      },
    );
  }
}

// ignore: non_constant_identifier_names
Widget BuildCategoryDetailsItem(List<Articles>? articles) => ListView.builder(
  itemBuilder: (context, index) => NewsItemBuilder(articles![index], context),
  itemCount: articles?.length ?? 0,
);
