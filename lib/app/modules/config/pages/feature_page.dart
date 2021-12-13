import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FeaturePage extends StatefulWidget {
  @override
  _FeaturePageState createState() => _FeaturePageState();
}

class _FeaturePageState extends State<FeaturePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sugestão de Melhoria'),
      ),
      body: WebView(
        initialUrl: 'https://docs.google.com/forms/d/e/1FAIpQLSc8ustIoyimgkNkTtHR1djTF1duIPw182qAP3IFeZuRDbRjzQ/viewform',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}