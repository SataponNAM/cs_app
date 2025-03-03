import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/webview.dart';

class CourseProcessionPage extends StatefulWidget {
  const CourseProcessionPage({super.key});

  @override
  State<CourseProcessionPage> createState() => _CourseProcessionPageState();
}

class _CourseProcessionPageState extends State<CourseProcessionPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ขบวนวิชา'),
        centerTitle: true,
      ),
      body: Webview(url: "http://cs.kmutnb.ac.th/course.jsp")
    );
  }

}