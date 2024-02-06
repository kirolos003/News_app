
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'dart:convert';

import '../../models/NewsResponse/NewsModel.dart';
import '../../models/sources/SourcesRespons.dart';

@singleton
class ApiManager {
  static const baseUrl = 'newsapi.org';
  static const key = '8bc9767c8ffc48d484f0af085e0fc3d4';

   Future<SourcesResponse> getSources(String categoryName) async {
    var url = Uri.https(
      baseUrl, 'v2/top-headlines/sources', {
      'apiKey': key,
      'category': categoryName
    });
    var response = await http.get(url);
    var json = jsonDecode(response.body);
    var sourcesResponse = SourcesResponse.fromJson(json);
    return sourcesResponse;
  }

   Future<NewsModel> getNews(String categoryName) async {
    var url = Uri.https(
        baseUrl, 'v2/top-headlines', {
      'apiKey': key,
      'q': categoryName
    });
    var response = await http.get(url);
    var json = jsonDecode(response.body);
    var newsResponse = NewsModel.fromJson(json);
    return newsResponse;
  }

   Future<NewsModel> getSearch(String value) async {
    var url = Uri.https(
      baseUrl, 'v2/everything', {
      'apiKey': key,
      'q': value,
    });
    var response = await http.get(url);
    var json = jsonDecode(response.body);
    var searchResponse = NewsModel.fromJson(json);
    return searchResponse;
  }

}
