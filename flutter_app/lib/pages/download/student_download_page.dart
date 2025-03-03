import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/webview.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

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
