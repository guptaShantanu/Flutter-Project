import 'package:flutter/material.dart';
import 'package:user/utils/urls.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

class NavigationController extends StatelessWidget {
  NavigationController(this._webViewController);

  final Future<WebViewController> _webViewController;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _webViewController,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController controller = snapshot.data;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: !webViewReady
                  ? null
                  : () async {
                      if (await controller.canGoBack()) {
                        controller.goBack();
                      } else {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(
                            "Can't go back",
                            textAlign: TextAlign.center,
                          ),
                        ));
                      }
                    },
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: !webViewReady
                  ? null
                  : () async {
                      if (await controller.canGoForward()) {
                        controller.goForward();
                      } else {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(
                            "Can't go forward",
                            textAlign: TextAlign.center,
                          ),
                        ));
                      }
                    },
            ),
            IconButton(
              icon: Icon(Icons.home),
              onPressed: !webViewReady
                  ? null
                  : () async {
                      controller.loadUrl(URL.url1);
                    },
            ),
            IconButton(
              icon: Icon(Icons.account_box),
              onPressed: !webViewReady
                  ? null
                  : () async {
                      controller.loadUrl(URL.url2);
                    },
            ),
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: !webViewReady
                  ? null
                  : () async {
                      controller.loadUrl(URL.url3);
                    },
            ),
          ],
        );
      },
    );
  }
}
