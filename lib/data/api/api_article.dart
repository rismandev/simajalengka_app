import 'package:simajalengka_app/data/api/api_base.dart';
import 'dart:convert';

import 'package:simajalengka_app/data/model/article.dart';
import 'package:http/http.dart' as http;

class ApiArticle {
  Future<ArticlesResult> topHeadlines() async {
    String _requestUrl =
        "top-headlines?country=${ApiBase.country}&category=${ApiBase.category}&apiKey=${ApiBase.apiKey}&pageSize=100";
    final response = await http.get(ApiBase.baseUrl + _requestUrl);
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return ArticlesResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal memuat berita');
    }
  }
}
