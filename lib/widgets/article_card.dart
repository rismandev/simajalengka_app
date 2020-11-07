import 'package:flutter/material.dart';
import 'package:simajalengka_app/common/navigation.dart';
import 'package:simajalengka_app/data/model/article.dart';
import 'package:simajalengka_app/ui/article/index.dart';

class ArticleCard extends StatelessWidget {
  final Article article;

  const ArticleCard({
    Key key,
    this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: _cardSecond(context),
    );
  }

  Container _cardSecond(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300],
            offset: Offset.zero,
            blurRadius: 10,
            spreadRadius: 1.5,
          ),
        ],
      ),
      child: InkWell(
        onTap: () => Navigation.intentWithData(
          ArticleDetailPage.routeName,
          article,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            article.urlToImage == null
                ? Container(
                    width: 100,
                    height: 120,
                    alignment: Alignment.center,
                    child: Icon(Icons.error),
                  )
                : Image.network(
                    article.urlToImage,
                    width: 100,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      article.title ?? "",
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: Colors.grey[800], fontWeight: FontWeight.w700),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: Text(
                        article.author ?? "",
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
