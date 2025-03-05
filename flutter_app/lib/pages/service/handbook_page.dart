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
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.deepPurple.shade800),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'คู่มือนักศึกษา',
          style: TextStyle(
            color: Colors.deepPurple.shade800,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Webview(url: "http://cs.kmutnb.ac.th/guide-step.jsp",)
    );
  }

}