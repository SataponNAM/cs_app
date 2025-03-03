import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/webview.dart';

class StudentAffairsPage extends StatefulWidget {
  const StudentAffairsPage({super.key});

  @override
  State<StudentAffairsPage> createState() => _StudentAffairsPageState();
}

class _StudentAffairsPageState extends State<StudentAffairsPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('งานกิจการนักศึกษา'),
        centerTitle: true,
      ),
      body: Webview(url: "http://cs.kmutnb.ac.th/reg-student-affairs.jsp")
    );
  }
}