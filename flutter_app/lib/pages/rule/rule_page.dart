import 'package:flutter/material.dart';

class RulePage extends StatefulWidget {
  const RulePage({super.key});

  @override
  State<RulePage> createState() => _RulePageState();
}

class _RulePageState extends State<RulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
              title: const Text('งานวิชาการ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
              title: const Text('งานกิจการนักศึกษา',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
              title: const Text('ระดับบัณฑิตศึกษา',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {}),
        ),
      ],
    ));
  }
}
