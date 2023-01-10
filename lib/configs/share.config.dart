import 'package:flutter_share/flutter_share.dart';

Future<void> shareUrl(String title, String url) async {
  print("URL ARGS :: " + url.toString());
  // String deepLink = await  FirebaseDynamicLinkService.createDynamicLink(false, url);
  await FlutterShare.share(
    title: title,
    text: title,
    linkUrl: url,
  );
}