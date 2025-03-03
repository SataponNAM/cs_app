import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/webview.dart';

class CsbPage extends StatefulWidget {
  const CsbPage({super.key});

  @override
  State<CsbPage> createState() => _CsbPageState();
}

class _CsbPageState extends State<CsbPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('โครงการพิเศษ(สองภาษา)'),
        centerTitle: true,
      ),

      body: Webview(url: "http://www.cs.kmutnb.ac.th/csb.jsp")
    );
  }

}
