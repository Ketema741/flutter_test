import 'package:dio/dio.dart';
import 'package:flutter_news_app/models/new_model.dart';

class APIService {
  static const apiKey = "006e0a23e1ce46dd8621d080837091d2";
  Dio dio = Dio(
    BaseOptions(baseUrl: "https://newsapi.org/v2", queryParameters: {
      "apiKey": "006e0a23e1ce46dd8621d080837091d2",
      "pageSize": 5,
      "language": "en",
    }),
  );
  APIService();

  Future<List<NewModel>> fetchAll({String? q = "Turkey", int page = 1}) async {
    try {
      Response response = await dio.get("/everything", queryParameters: {
        "q": q,
        "page": page,
      });
     
      if (response.statusCode == 200) {
        List<NewModel> news =
            response.data['articles'].map<NewModel>((article) {
          return NewModel.fromJson(article);
        }).toList();
        return news;
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<NewModel>> getTopHeadlines() async {
    Response response = await dio.get("/top-headlines");
    List<NewModel> news = response.data['articles'].map<NewModel>((article) {
      return NewModel.fromJson(article);
    }).toList();
    return news;
  }


  // Search Api
  Future<List<NewModel>> fetchSearch({String? searchQuery, String? from}) async {
    try {
      Response response = await dio.get("/everything", queryParameters: {
        "q": searchQuery,
        "from":from,
      });
     
      if (response.statusCode == 200) {
        List<NewModel> news =
            response.data['articles'].map<NewModel>((article) {
          return NewModel.fromJson(article);
        }).toList();
        return news;
      } 
      else {
        throw Exception("Error Searching Articles");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

}
