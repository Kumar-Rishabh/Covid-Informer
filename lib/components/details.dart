import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';



class DetailWeb extends StatelessWidget {
  DetailWeb({required this.url}) ;
  final String url;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: WebView(
              initialUrl: url,
              javascriptMode: JavascriptMode.unrestricted,
              allowsInlineMediaPlayback: true,
            )
        )
    );
  }
}

