import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(243, 237, 247, 100),
          title: Image.asset(
            'assets/images/logo.png',
            width: 50,
          ),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.only(top: 20),
          children: [
            const Center(
              child: Text('แนะนำภาควิชา',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
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
                  title: const Text(
                    'โครงสร้างภาควิชา',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {}),
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
                  title: const Text(
                    'บุคลากรสายวิชาการ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {}),
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
                  title: const Text(
                    'บุคลากรสายสนับสนุน',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {}),
            ),
          ],
        ));
  }
}
