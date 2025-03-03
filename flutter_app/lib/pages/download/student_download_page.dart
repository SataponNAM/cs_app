import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/webview.dart';

class StudentDownloadPage extends StatefulWidget {
  const StudentDownloadPage({super.key});

  @override
  State<StudentDownloadPage> createState() => _StudentDownloadPageState();
}

class _StudentDownloadPageState extends State<StudentDownloadPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ดาวน์โหลด'),
        centerTitle: true,
      ),
      body: Webview(url: "http://cs.kmutnb.ac.th/student_download.jsp")
    );
  }
}
