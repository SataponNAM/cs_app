import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/webview.dart';

class StaffDownloadPage extends StatefulWidget {
  const StaffDownloadPage({super.key});

  @override
  State<StaffDownloadPage> createState() => _StaffDownloadPageState();
}

class _StaffDownloadPageState extends State<StaffDownloadPage> {

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
          'ดาวน์โหลดสำหรับบุคคลากร',
          style: TextStyle(
            color: Colors.deepPurple.shade800,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: Webview(url: "http://cs.kmutnb.ac.th/staff_download.jsp")
    );
  }
}