import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:simajalengka_app/common/function.dart';
import 'package:simajalengka_app/common/result_state.dart';
import 'package:simajalengka_app/data/provider/database_provider.dart';
import 'package:simajalengka_app/widgets/article_card.dart';
import 'package:simajalengka_app/widgets/custom_platform.dart';

class BookmarkPage extends StatelessWidget {
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
          'Berita tersimpan',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        actions: [
          InkWell(
            onTap: launchURL,
            child: Container(
              padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
              child: Image.asset(
                'assets/icons/instagram.png',
                width: 25,
                height: 25,
              ),
            ),
          ),
        ],
      ),
      body: _buildList(),
    );
  }

  CupertinoPageScaffold _buildIOS(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Berita tersimpan',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      child: _buildList(),
    );
  }

  Widget _buildList() {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.HasData) {
          return ListView.builder(
            itemCount: provider.bookmarks.length,
            padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
            itemBuilder: (context, index) {
              return ArticleCard(article: provider.bookmarks[index]);
            },
          );
        } else {
          return Container(
            alignment: Alignment.center,
            child: Text(
              provider.message,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(color: Colors.red, fontWeight: FontWeight.w600),
            ),
          );
        }
      },
    );
  }
}
