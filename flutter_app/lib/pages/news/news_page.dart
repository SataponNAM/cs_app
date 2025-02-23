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
      padding: const EdgeInsets.only(top: 20),
      children: [
        const Center(
          child: Text(
            'ข่าวสารและกิจกรรม',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
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
              title: const Text(
                'ข่าวภาควิชา',
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
                'ข่าวคณะและมหาวิทยาลัย',
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
                'ข่าวทุนการศึกษา',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {}),
        ),
      ],
    ));
  }
}
