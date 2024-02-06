import 'package:flutter/material.dart';
import 'package:news_app/UI/screens/Home/home_drawer.dart';
import 'package:news_app/features/search/presentation/pages/search_screen.dart';
import 'package:news_app/provider/app_provider.dart';
import 'package:news_app/shared/components.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    return Scaffold(
      drawer: const HomeDrawer(),
      appBar: AppBar(
        title: const Text('News App'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
              icon: const Icon(
                Icons.search,
                size: 30,
              ),
              onPressed: () {
                navigateTo(context, const MainSearchScreen());
              },
            ),
          )
        ],
      ),
      body: provider.selectedWidget,
    );
  }
}
