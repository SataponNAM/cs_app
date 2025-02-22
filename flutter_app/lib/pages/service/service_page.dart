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
      children: [
        const Center(
          child: Text('บริการนักศึกษา', style: TextStyle(fontSize: 22)),
        ),
        ListTile(
          // leading: Icon(Icons.newspaper),
          title: const Text('อาจารย์ที่ปรึกษา'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {}
        ),
        ListTile(
          // leading: Icon(Icons.newspaper),
          title: const Text('คู่มือนักศึกษา'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {}
        ),
        ListTile(
          // leading: Icon(Icons.newspaper),
          title: const Text('ขบวนวิชา'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {}
        ),
      ],
    )
    );
  }
}