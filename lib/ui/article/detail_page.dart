import 'package:flutter/material.dart';
import 'package:simajalengka_app/common/navigation.dart';
import 'package:simajalengka_app/data/model/article.dart';
import 'package:simajalengka_app/ui/article/index.dart';

class ArticleDetailPage extends StatelessWidget {
  static String routeName = 'article_detail';

  final Article article;

  const ArticleDetailPage({
    @required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          article.title,
          style: Theme.of(context)
              .textTheme
              .subtitle2
              .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            article.urlToImage == null
                ? Container(
                    height: 200,
                    alignment: Alignment.center,
                    child: Icon(Icons.error),
                  )
                : Hero(
                    tag: article.urlToImage,
                    child: Image.network(article.urlToImage),
                  ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.description ?? "",
                    style: Theme.of(context).textTheme.caption.copyWith(
                        color: Colors.grey[800], fontWeight: FontWeight.w400),
                  ),
                  Divider(color: Colors.grey),
                  Text(
                    article.title ?? "",
                    style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.grey[900], fontWeight: FontWeight.w700),
                  ),
                  Divider(color: Colors.grey),
                  Text(
                    'Tanggal: ${article.publishedAt}',
                    style: Theme.of(context).textTheme.caption.copyWith(
                        color: Colors.grey[800], fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Penulis: ${article.author}',
                    style: Theme.of(context).textTheme.caption.copyWith(
                        color: Colors.grey[800], fontWeight: FontWeight.w400),
                  ),
                  Divider(color: Colors.grey),
                  Text(
                    article.content ?? "",
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: Colors.grey[800], fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 10),
                  RaisedButton(
                    child: Text('Selengkapnya'),
                    onPressed: () => Navigation.intentWithData(
                      ArticleWebView.routeName,
                      article.url,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
