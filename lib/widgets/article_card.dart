import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simajalengka_app/common/navigation.dart';
import 'package:simajalengka_app/common/styles.dart';
import 'package:simajalengka_app/data/model/article.dart';
import 'package:simajalengka_app/data/provider/database_provider.dart';
import 'package:simajalengka_app/data/provider/preferences_provider.dart';
import 'package:simajalengka_app/ui/article/index.dart';

class ArticleCard extends StatelessWidget {
  final Article article;

  const ArticleCard({Key key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder(
          future: provider.isBookmarked(article.url),
          builder: (context, snapshot) {
            bool isBookmark = snapshot.data ?? false;
            return _buildCard(
              context,
              isBookmark,
              onBookmark: () {
                if (isBookmark) {
                  provider.removeBookmark(article.url);
                } else {
                  provider.addBookmark(article);
                }
              },
            );
          },
        );
      },
    );
  }

  Material _buildCard(
    BuildContext context,
    bool isBookmark, {
    Function onBookmark,
  }) {
    bool isDark = Provider.of<PreferencesProvider>(context).isDarkTheme;
    return Material(
      child: Container(
        margin: EdgeInsets.fromLTRB(16, 5, 16, 14),
        clipBehavior: Clip.antiAlias,
        decoration: isDark ? _darkDecorationBox() : _lightDecorationBox(),
        child: InkWell(
          highlightColor: Colors.transparent,
          onTap: () => Navigation.intentWithData(
            ArticleDetailPage.routeName,
            article,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              article.urlToImage == null
                  ? Container(
                      width: 100,
                      height: 120,
                      alignment: Alignment.center,
                      child: Icon(Icons.error),
                    )
                  : Container(
                      width: 100,
                      height: 120,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            article.urlToImage,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            child: _iconBookmark(
                              onBookmark,
                              isBookmark,
                              isDark: isDark,
                            ),
                          ),
                        ],
                      ),
                    ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                      child: Text(
                        article.title ?? "",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 5, 10),
                              child: Text(
                                article.author ?? "",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _iconBookmark(
    Function onBookmark,
    bool isBookmark, {
    bool isDark = false,
  }) {
    return Container(
      margin: EdgeInsets.only(left: 5, top: 5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: isDark ? darkPrimaryColor : Colors.white,
        shape: BoxShape.circle,
      ),
      child: InkWell(
        onTap: onBookmark,
        child: Icon(
          isBookmark ? Icons.bookmark : Icons.bookmark_border,
          size: 20,
          color: isDark ? Colors.white : primaryColor,
        ),
      ),
    );
  }

  BoxDecoration _lightDecorationBox() {
    return BoxDecoration(
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
    );
  }

  BoxDecoration _darkDecorationBox() {
    return BoxDecoration(
      color: darkPrimaryColor,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey[800],
          offset: Offset.zero,
          blurRadius: 10,
          spreadRadius: 1.5,
        ),
      ],
    );
  }
}
