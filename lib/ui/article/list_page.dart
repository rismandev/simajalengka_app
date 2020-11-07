import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simajalengka_app/data/model/article.dart';
import 'package:simajalengka_app/data/provider/article_provider.dart';
import 'package:simajalengka_app/widgets/article_card.dart';
import 'package:simajalengka_app/widgets/custom_platform.dart';

class ArticleListPage extends StatelessWidget {
  static String routeName = 'article_list';

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIOS,
    );
  }

  Scaffold _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Simajalengka',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      body: _buildList(context),
    );
  }

  CupertinoPageScaffold _buildIOS(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Simajalengka',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<ArticleProvider>(
      builder: (context, ArticleProvider model, _) {
        if (model.state == ResultState.Loading) {
          return Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              backgroundColor: Theme.of(context).primaryColor,
            ),
          );
        } else if (model.state == ResultState.HasData) {
          List<Article> _articles = model.result.articles;
          return ListView.builder(
            itemCount: _articles.length,
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            itemBuilder: (context, index) {
              return ArticleCard(article: _articles[index]);
            },
          );
        } else if (model.state == ResultState.Error ||
            model.state == ResultState.NoData) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              model.message,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(color: Colors.red, fontWeight: FontWeight.w600),
            ),
          );
        } else {
          return Text("");
        }
      },
    );
  }
}
