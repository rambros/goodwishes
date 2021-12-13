import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MeditationCoursePage extends StatefulWidget {
  const MeditationCoursePage({Key? key}) : super(key: key);

  @override
  _MeditationCoursePageState createState() => _MeditationCoursePageState();
}

class _MeditationCoursePageState extends State<MeditationCoursePage> {

  @override
  Widget build(BuildContext context) {
    final _controller = Completer<WebViewController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Curso de Raja Yoga'),
      ),
      backgroundColor: Colors.white,  //Theme.of(context).accentColor,
      body: WebView(
        initialUrl: 'https://ead.brahmakumaris.org.br',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }
}
