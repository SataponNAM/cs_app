import 'package:flutter/material.dart';
import 'package:cs_app/widgets/webview.dart';

class StudentAffairsPage extends StatefulWidget {
  const StudentAffairsPage({super.key});

  @override
  State<StudentAffairsPage> createState() => _StudentAffairsPageState();
}

class _StudentAffairsPageState extends State<StudentAffairsPage> {
  
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
          'งานกิจการนักศึกษา',
          style: TextStyle(
            color: Colors.deepPurple.shade800,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Webview(url: "http://cs.kmutnb.ac.th/reg-student-affairs.jsp")
    );
  }
}