import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/webview.dart';


class GraduateStudentPage extends StatefulWidget {
  const GraduateStudentPage({super.key});

  @override
  State<GraduateStudentPage> createState() => _GraduateStudentPageState();
}

class _GraduateStudentPageState extends State<GraduateStudentPage> {

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
          'ระดับบัณฑิตศึกษา',
          style: TextStyle(
            color: Colors.deepPurple.shade800,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Webview(url: "http://cs.kmutnb.ac.th/reg-graduate-student.jsp")
    );
  }

}