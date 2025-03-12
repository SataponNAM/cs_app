import 'package:flutter/material.dart';
import 'package:cs_app/widgets/webview.dart';
import '../../assets/constants.dart' as constants;

class StudentDownloadPage extends StatefulWidget {
  const StudentDownloadPage({super.key});

  @override
  State<StudentDownloadPage> createState() => _StudentDownloadPageState();
}

class _StudentDownloadPageState extends State<StudentDownloadPage> {

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
          'ดาวน์โหลดสำหรับนักศึกษา',
          style: TextStyle(
            color: Colors.deepPurple.shade800,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Webview(url: constants.STUDENT_DOWNLOAD)
    );
  }
}
