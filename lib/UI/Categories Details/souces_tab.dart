import 'package:flutter/material.dart';
import 'package:news_app/Network/remote/Api_manager.dart';
import 'package:news_app/UI/Categories%20Details/source_tab_widget.dart';
import 'package:news_app/model/sources/Sources.dart';
import 'package:news_app/provider/app_provider.dart';
import 'package:provider/provider.dart';

class SourcesTabsWidgets extends StatelessWidget {
  List<Source> sources;
  SourcesTabsWidgets(this.sources);

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
                ApiManager.getNewsWithSource('${sources[newIndex]}');
              },
              isScrollable: true,
              tabs: sources
                  .map((Source) => TabWidget(Source, sources.indexOf(Source) == provider.current))
                  .toList()),
        ],
      ),
    );
  }
}
