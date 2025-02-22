import 'package:flutter/material.dart';
import 'package:flutter_app/pages/main_pages/home_page.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        const Center(
          child: Text('ข่าวสารและกิจกรรม', style: TextStyle(fontSize: 22)),
        ),
        ListTile(
          // leading: Icon(Icons.newspaper),
          title: const Text('ข่าวภาควิชา'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {}
        ),
        ListTile(
          // leading: Icon(Icons.newspaper),
          title: const Text('ข่าวคณะและมหาวิทยาลัย'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {}
        ),
        ListTile(
          // leading: Icon(Icons.newspaper),
          title: const Text('ข่าวทุนการศึกษา'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {}
        ),
      ],
    ));
  }
}
