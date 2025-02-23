import 'package:flutter/material.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: const EdgeInsets.only(top: 20),
      children: [
        const Center(
          child: Text('บริการนักศึกษา',
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
              title: const Text('อาจารย์ที่ปรึกษา', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
              title: const Text('คู่มือนักศึกษา', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
              title: const Text('ขบวนวิชา', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {}),
        ),
      ],
    ));
  }
}
