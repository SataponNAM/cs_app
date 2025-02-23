import 'package:flutter/material.dart';
import 'package:flutter_app/pages/download/staff_download_page.dart';
import 'package:flutter_app/pages/download/student_download_page.dart';

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
        padding: const EdgeInsets.only(top: 20),
        children: [
          const Center(
            child: Text(
              'ดาวน์โหลด', 
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)
            ),
          ),
          
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color.fromRGBO(240, 221, 252, 0.612),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              // leading: Icon(Icons.newspaper),
              title: const Text('นักศึกษา', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => StudentDownloadPage())
                );
              },
            ),
          ),

          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color.fromRGBO(240, 221, 252, 0.612),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              // leading: Icon(Icons.newspaper),
              title: const Text('บุคลากร', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => StaffDownloadPage())
                );
              },
            ),
          ),
        ],
      )
    );
  }
}