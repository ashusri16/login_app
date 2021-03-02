import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Policy extends StatefulWidget {
  @override
  _PolicyState createState() => _PolicyState();
}

class _PolicyState extends State<Policy> {
  @override
  void initState() {
    WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Privacy Policy",
        ),
        centerTitle: true,
      ),
      body: WebView(
        initialUrl: 'https://www.pdfcomplete.com/cms/Company/privacy.aspx',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
