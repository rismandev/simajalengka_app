import 'package:url_launcher/url_launcher.dart';

void launchURL() async {
  const url = 'https://www.instagram.com/simajalengka/';
  if (await canLaunch(url)) {
    await launch(
      url,
      universalLinksOnly: true,
    );
  } else {
    throw 'Could not launch $url';
  }
}
