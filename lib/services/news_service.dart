import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/news_model.dart';

import 'package:news_app/utils/keys.dart';

class NewsService with ChangeNotifier {
  static const String URL_NEWS = 'https://newsapi.org/v2';

  List<Article> headlines = [];

  Future<News> getTopHeadLines() async {
    final url = '$URL_NEWS/top-headlines?country=us&apiKey=$API_KEY';
    final response = await http.get(url);
    final news = newsFromJson(response.body);
    notifyListeners();
    return news;
  }
}
