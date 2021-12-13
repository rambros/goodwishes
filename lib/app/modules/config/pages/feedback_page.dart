import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Avaliação do MeditaBK'),
      ),
      body: WebView(
        initialUrl: 'https://docs.google.com/forms/d/e/1FAIpQLSfQ99__todk2o-kRIux56NLBuFnsOYi7mPyUnAAszUCrsjR3A/viewform',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}