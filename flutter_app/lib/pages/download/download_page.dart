import 'package:flutter/material.dart';

class DownloadPage extends StatefulWidget {
  const DownloadPage({super.key});

  @override
  State<DownloadPage> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        const Center(
          child: Text('ดาวน์โหลด', style: TextStyle(fontSize: 22)),
        ),
        ListTile(
          // leading: Icon(Icons.newspaper),
          title: const Text('นักศึกษา'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
        ListTile(
          // leading: Icon(Icons.newspaper),
          title: const Text('บุคลากร'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
      ],
    ));
  }
}