import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class WebViewScreen extends StatefulWidget {
  WebViewScreen({Key? key, this.url=""}) : super(key: key);
  String url = "";
  static const String routeName = "/webview";
  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: WebViewPlus(

        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: widget.url,
      ),
    ));
  }
}
