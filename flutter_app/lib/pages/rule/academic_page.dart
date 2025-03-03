import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/webview.dart';

class AcademicPage extends StatefulWidget {
  const AcademicPage({super.key});

  @override
  State<AcademicPage> createState() => _AcademicPageState();
}

class _AcademicPageState extends State<AcademicPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('งานวิชาการ'),
        centerTitle: true,
      ),
      body: Webview(url: "http://cs.kmutnb.ac.th/reg-academic.jsp")
    );
  }
  
}