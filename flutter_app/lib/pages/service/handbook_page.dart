import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HandbookPage extends StatefulWidget {
  const HandbookPage({super.key});

  @override
  State<HandbookPage> createState() => _HandbookPageState();
}

class _HandbookPageState extends State<HandbookPage> {
  late WebViewController webViewController;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)  // เปิดใช้งาน JavaScript
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (progress) {},
        onPageStarted: (String url) {
          setState(() {
            isLoading = true;
          });
        },
        onPageFinished: (String url) {
          webViewController.runJavaScript('''
            var meta = document.createElement('meta');
            meta.name = 'viewport';
            meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';
            document.getElementsByTagName('head')[0].appendChild(meta);

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

            // Change body background color to white
            document.body.style.backgroundColor = 'white';
          ''');
          setState(() {
            isLoading = false;
          });
        },
        onWebResourceError: (WebResourceError error) {
          //Things to do when the page has error when loading
       },
      ))
      ..loadRequest(Uri.parse('http://cs.kmutnb.ac.th/guide-step.jsp'));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('คู่มือนักศึกษา'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: webViewController),
          if (isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}