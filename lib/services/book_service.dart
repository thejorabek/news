import 'package:book/models/news_model.dart';
import 'package:dio/dio.dart';

class BookService {
  static Future<NewsModel> bookService() async {
    Response res =
        await Dio().get('https://newsapi.org/v2/everything?q=tesla&from=2022-08-06&sortBy=publishedAt&apiKey=2ef3f8a720984bd4b52c4b25b12f2fb0');
    return NewsModel.fromJson(res.data);
  }
}