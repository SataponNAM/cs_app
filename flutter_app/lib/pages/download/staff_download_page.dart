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
      appBar: AppBar(
        title: const Text('ดาวน์โหลด'),
        centerTitle: true,
      ),

      body: Webview(url: "http://cs.kmutnb.ac.th/staff_download.jsp")
    );
  }
}