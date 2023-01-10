import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:webview_flutter/webview_flutter.dart';

class BecomeLecturer extends StatefulWidget {
  const BecomeLecturer({Key? key}) : super(key: key);

  @override
  _BecomeLecturerState createState() => _BecomeLecturerState();
}

class _BecomeLecturerState extends State<BecomeLecturer> {
  final Uri _url = Uri.parse('https://digischoolglobal.com/become-a-lecturer');
  @override
  Widget build(BuildContext context) {
    return const WebView(
      initialUrl: '',
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }
}
