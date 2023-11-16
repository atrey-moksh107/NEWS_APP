import 'dart:convert';

import 'package:api_project/models/categories_news_model.dart';
import 'package:api_project/models/news_channel_headlines_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;



class NewsRepository {
  Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadlinesApi(String channelName) async {
    String url = 'https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=c98f273e77834bc2af860db3b0f0993f';
 final response = await http.get(Uri.parse(url));
 if (kDebugMode) {
   print(response.body);
 }

 if(response.statusCode == 200){
   final body = jsonDecode(response.body);
   return NewsChannelsHeadlinesModel.fromJson(body);

 }
 throw Exception('Error');
  }


  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async {
    String url = 'https://newsapi.org/v2/everything?q=${category}&apiKey=c98f273e77834bc2af860db3b0f0993f';
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }

    if(response.statusCode == 200){
      final body = jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);

    }
    throw Exception('Error');
  }


}