import 'package:flutter/material.dart';
import 'package:simajalengka_app/widgets/custom_scaffold.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleWebView extends StatelessWidget {
  static String routeName = 'article_webview';

  final String url;

  const ArticleWebView({
    @required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: url,
      ),
    );
  }
}
