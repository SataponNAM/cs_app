import 'package:flutter/material.dart';
import 'package:cs_app/widgets/webview.dart';
import '../../assets/constants.dart' as constants;

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
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.deepPurple.shade800),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'โครงการพิเศษ(สองภาษา)',
          style: TextStyle(
            color: Colors.deepPurple.shade800,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: Webview(url: constants.CSB_LINK)
    );
  }

}
