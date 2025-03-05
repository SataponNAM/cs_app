import 'package:flutter/material.dart';

class BachelorNormalPage extends StatefulWidget {
  const BachelorNormalPage({super.key});

  @override
  State<BachelorNormalPage> createState() => _BachelorNormalPageState();
}

class _BachelorNormalPageState extends State<BachelorNormalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.deepPurple.shade800),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Text("Bachelor")
      ),
    );
  }
}