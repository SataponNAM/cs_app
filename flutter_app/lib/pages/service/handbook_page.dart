import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/webview.dart';

class HandbookPage extends StatefulWidget {
  const HandbookPage({super.key});

  @override
  State<HandbookPage> createState() => _HandbookPageState();
}

class _HandbookPageState extends State<HandbookPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('คู่มือนักศึกษา'),
        centerTitle: true,
      ),
      body: Webview(url: "http://cs.kmutnb.ac.th/guide-step.jsp",)
    );
  }

}