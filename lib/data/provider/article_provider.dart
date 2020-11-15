import 'package:flutter/material.dart';
import 'package:simajalengka_app/common/result_state.dart';
import 'package:simajalengka_app/data/api/api_article.dart';
import 'package:simajalengka_app/data/model/article.dart';

class ArticleProvider extends ChangeNotifier {
  final ApiArticle apiArticle;

  ArticleProvider({
    @required this.apiArticle,
  }) {
    _fetchAllArticle();
  }

  ArticlesResult _articlesResult;
  String _message = '';
  ResultState _state;

  String get message => _message;

  ArticlesResult get result => _articlesResult;

  ResultState get state => _state;

  Future<dynamic> _fetchAllArticle() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      ArticlesResult result = await apiArticle.topHeadlines();
      if (result.articles.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = "No Article Found";
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _articlesResult = result;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = "Error $e";
    }
  }
}
