import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
                  onTap: () {
                    Navigator.pushNamed(context, '/departmentNews');
                  }),
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
                  onTap: () {
                    Navigator.pushNamed(context, '/uniNews');
                  }),
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
                  onTap: () {
                    Navigator.pushNamed(context, '/scholarshipNews');
                  }),
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
                    'ข่าวรับสมัครงาน-ประชาสัมพันธ์',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.pushNamed(context, '/rescruitmentNews');
                  }),
            ),
          ],
        ));
  }
}
