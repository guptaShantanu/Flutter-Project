import 'dart:async';

import 'package:flutter/material.dart';
import 'package:user/utils/urls.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatefulWidget {
  static String route = "/homescreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  String url = URL.url1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
//      appBar: AppBar(
//        title: Center(child: Text("Sui Dhaga", textAlign: TextAlign.center)),
//      ),
//      bottomNavigationBar: Container(
//        height: 60,
//        child: NavigationController(_controller.future),
//      ),
        body: Builder(
          builder: (BuildContext context) {
            return WebView(
              initialUrl: url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
            );
          },
        ),
      ),
    );
  }
}
