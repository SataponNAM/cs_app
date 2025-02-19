import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CsbPage extends StatefulWidget {
  const CsbPage({super.key});

  @override
  State<CsbPage> createState() => _CsbPageState();
}

class _CsbPageState extends State<CsbPage> {
  late WebViewController webViewController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    webViewController = WebViewController()
    ..loadRequest(Uri.parse('http://www.cs.kmutnb.ac.th/csb.jsp'));
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: webViewController);
  }
}