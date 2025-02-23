import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CsbPage extends StatefulWidget {
  const CsbPage({super.key});

  @override
  State<CsbPage> createState() => _CsbPageState();
}

class _CsbPageState extends State<CsbPage> {
  late WebViewController webViewController;
   bool isLoading = true;

  @override
  void initState() {
    super.initState();
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)  // เปิดใช้งาน JavaScript
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (progress) {},
        onPageStarted: (String url) {},
        onPageFinished: (String url) {
          webViewController.runJavaScript('''
            // Navigation Bar
            var navElement = document.querySelector('nav');
            if (navElement) {
              navElement.style.display = 'none';
            }

            // Hide footer
            var footerElement = document.querySelector('footer');
            if (footerElement) {
              footerElement.style.display = 'none';
            }

            // Hide class "probootstrap-section probootstrap-section-colored"
            var sections = document.querySelectorAll('.probootstrap-section.probootstrap-section-colored');
            sections.forEach(section => {
              section.style.display = 'none';
            });
          ''');
          isLoading = false;
          setState(() {});
        },
        onWebResourceError: (WebResourceError error) {
          //Things to do when the page has error when loading
       },
      ))
      ..loadRequest(Uri.parse('http://www.cs.kmutnb.ac.th/csb.jsp'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: webViewController),
    );
  }
}
