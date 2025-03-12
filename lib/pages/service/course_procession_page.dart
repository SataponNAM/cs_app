import 'package:flutter/material.dart';
import 'package:cs_app/widgets/webview.dart';
import '../../assets/constants.dart' as constants;

class CourseProcessionPage extends StatefulWidget {
  const CourseProcessionPage({super.key});

  @override
  State<CourseProcessionPage> createState() => _CourseProcessionPageState();
}

class _CourseProcessionPageState extends State<CourseProcessionPage> {

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
          'ขบวนวิชา',
          style: TextStyle(
            color: Colors.deepPurple.shade800,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Webview(url: constants.COURSE_PROCESSION)
    );
  }

}