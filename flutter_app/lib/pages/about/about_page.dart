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
        body: ListView(
      children: [
        const Center(
          child: Text('แนะนำภาควิชา', style: TextStyle(fontSize: 22)),
        ),
        ListTile(
          // leading: Icon(Icons.newspaper),
          title: const Text('โครงสร้างภาควิชา'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {}
        ),
        ListTile(
          // leading: Icon(Icons.newspaper),
          title: const Text('บุคลากรสายวิชาการ'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {}
        ),
        ListTile(
          // leading: Icon(Icons.newspaper),
          title: const Text('บุคลากรสายสนับสนุน'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {}
        ),
      ],
    ));
  }
}