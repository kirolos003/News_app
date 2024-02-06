

import 'Articles.dart';

class NewsModel {
  String? status;
  int? totalResults;
  List<Articles>? articles;
  String? code ;
  String? message ;

  NewsModel({
      this.status, 
      this.totalResults, 
      this.articles,
      this.code,
      this.message,
  });

  NewsModel.fromJson(dynamic json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    totalResults = json['totalResults'];
    if (json['articles'] != null) {
      articles = [];
      json['articles'].forEach((v) {
        articles?.add(Articles.fromJson(v));
      });
    }
  }
}