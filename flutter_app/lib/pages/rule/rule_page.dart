import 'package:flutter/material.dart';
import 'package:flutter_app/pages/rule/academic_page.dart';
import 'package:flutter_app/pages/rule/finance_page.dart';
import 'package:flutter_app/pages/rule/graduate_student_page.dart';
import 'package:flutter_app/pages/rule/student_affairs_page.dart';

class RulePage extends StatefulWidget {
  const RulePage({super.key});

  @override
  State<RulePage> createState() => _RulePageState();
}

class _RulePageState extends State<RulePage> {
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
              child: Text('ระเบียบและประกาศ',
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
                  title: const Text('งานการเงิน',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.pushNamed(
                        context,
                        '/finance');
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
                  title: const Text('งานวิชาการ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.pushNamed(
                        context,
                        '/academic');
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
                  title: const Text('งานกิจการนักศึกษา',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.pushNamed(
                        context,
                        '/stdAffair');
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
                  title: const Text('ระดับบัณฑิตศึกษา',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.pushNamed(
                        context,
                        '/graduateStd');
                  }),
            ),
          ],
        ));
  }
}
