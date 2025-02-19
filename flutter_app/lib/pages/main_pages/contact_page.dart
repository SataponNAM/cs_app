import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          SizedBox(height: 20),
          Text(
            'ช่องทางติดต่อ',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
    
          SizedBox(height: 45),
          Row(
            children: [
              SizedBox(width: 50),
              Icon(Icons.location_on_rounded, size: 35),
              SizedBox(width: 40),
              Expanded(
                child: Text(
                  'ภาควิชาวิทยาการคอมพิวเตอร์และสารสนเทศ\nคณะวิทยาศาสตร์ประยุกต์\nมหาวิทยาลัยเทคโนโลยีพระจอมเกล้าพระนครเหนือ',
                  style: TextStyle(
                    fontSize: 16
                  ),
                ),
              ),
            ],
          ),
    
          SizedBox(height: 30),
          Row(
            children: [
              SizedBox(width: 50),
              Icon(IconlyBold.call, size: 35),
              SizedBox(width: 40),
              Text(
                '02-555-2000 ต่อ 4601, 4602\n(ในเวลาราชการ)',
                style: TextStyle(
                  fontSize: 16
                ),
              )
            ],
          ),
    
          SizedBox(height: 30),
          Row(
            children: [
              SizedBox(width: 50),
              Icon(Icons.facebook, size: 35),
              SizedBox(width: 40),
              Text(
                'CIS KMUTNB',
                style: TextStyle(
                  fontSize: 16
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}