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
      children: [
        const Center(
          child: Text('ระเบียบและประกาศ', style: TextStyle(fontSize: 22)),
        ),
        ListTile(
          // leading: Icon(Icons.newspaper),
          title: const Text('งานการเงิน'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {}
        ),
        ListTile(
          // leading: Icon(Icons.newspaper),
          title: const Text('งานวิชาการ'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {}
        ),
        ListTile(
          // leading: Icon(Icons.newspaper),
          title: const Text('งานกิจการนักศึกษา'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {}
        ),
        ListTile(
          // leading: Icon(Icons.newspaper),
          title: const Text('ระดับบัณฑิตศึกษา'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {}
        ),
      ],
    ));
  }
}