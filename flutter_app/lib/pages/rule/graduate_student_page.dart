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
      appBar: AppBar(
        title: const Text('ระดับบัณฑิตศึกษา'),
        centerTitle: true,
      ),
      body: Webview(url: "http://cs.kmutnb.ac.th/reg-graduate-student.jsp")
    );
  }

}